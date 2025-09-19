import time
import random

def medir_tempo(func):
    """Decorator para medir tempo de execução de uma função"""
    def wrapper(*args, **kwargs):
        inicio = time.time()
        resultado = func(*args, **kwargs)
        fim = time.time()
        print(f"Tempo da {func.__name__}: {round(fim - inicio, 3)} s")
        return resultado
    return wrapper

@medir_tempo
def popular_lista_aleatoria(qtd, inicio=100, fim=100000):
    return [random.randint(inicio, fim) for _ in range(qtd)]

@medir_tempo
def popular_lista_sequencial(qtd):
    return list(range(qtd))

@medir_tempo
def ordenar_lista(lista):
    lista.sort()
    return lista


def main():
    lista_aleatoria = popular_lista_aleatoria(100000)
    lista_sequencial = popular_lista_sequencial(100000)

    lista_aleatoria = ordenar_lista(lista_aleatoria)
    lista_sequencial = ordenar_lista(lista_sequencial)