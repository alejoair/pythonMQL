import dash
import dash_html_components as html
import dash_core_components as dcc
from dash.dependencies import Input, Output
import socket
import threading

entrada_socket= ""
ticks = []

def servidor():

    adress = ("localhost", 7800)
    server = socket.socket()
    server.bind(adress)
    server.listen(5)

    while True:
        server.settimeout(50)
        conexion, direccion = server.accept()
        print("servidor llamado")
        conexion.send(b"Soy el servidor")
        recibido = conexion.recv(32)
        global ticks
        ticks.append(float(recibido.decode("utf-8")))
        if len(ticks) > 50:
            ticks = ticks[-50:]

hilo = threading.Thread(target=servidor)
hilo.start()

app = dash.Dash()

app.layout = html.Div(id="main",children=[
    dcc.Graph(
        id="grafico",
        figure=
        {"data": [{"x": ticks,"type": "line", "name": "Ticks"}]}
    ),
    dcc.Interval(
        n_intervals=0,
        interval=1000,
        id="intervalo"
    )

]
)
@app.callback(
    Output(component_id="grafico",component_property="figure"),
    [Input(component_id="intervalo",component_property="n_intervals")]
)
def update_graph(datos_entrada):

    return {"data": [{"y": ticks,"type": "line", "name": "Ticks"}]}



app.run_server()
