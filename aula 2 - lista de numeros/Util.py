import random

class Util:
    @staticmethod
    def popular_lista_numeros_aleatorios(lista, quantidade, inicio, fim):
        """Popula uma lista com números inteiros aleatórios"""
        for _ in range(quantidade):
            numero = random.randint(inicio, fim - 1)
            lista.append(numero)

    @staticmethod
    def exibir_lista_numeros(lista):
        """Exibe números da lista"""
        for item in lista:
            print(item)

    @staticmethod
    def popular_lista_palavras_aleatorio(lista, quantidade, tamanho):
        """Popula a lista com palavras aleatórias"""
        letras = "abcdefghijklmnopqrstuvwxyz"
        for _ in range(quantidade):
            palavra = "".join(random.choice(letras) for _ in range(tamanho))
            lista.append(palavra)

    @staticmethod
    def exibir_lista_palavras(lista):
        """Exibe palavras da lista"""
        for item in lista:
            print(item)

    @staticmethod
    def popular_lista_numeros_arquivo(lista, nome_arquivo):
        """Salva os números da lista em um arquivo"""
        try:
            with open(nome_arquivo, "w", encoding="utf-8") as f:
                for numero in lista:
                    f.write(str(numero) + "\n")
            print(f"Números salvos no arquivo: {nome_arquivo}")
        except Exception as e:
            print("Erro ao salvar os números:", e)

    @staticmethod
    def popular_lista_palavras_arquivo(lista, nome_arquivo):
        """Salva as palavras da lista em um arquivo"""
        try:
            with open(nome_arquivo, "w", encoding="utf-8") as f:
                for palavra in lista:
                    f.write(palavra + "\n")
            print(f"Palavras salvas no arquivo: {nome_arquivo}")
        except Exception as e:
            print("Erro ao salvar as palavras:", e)


def main():
    lista_numeros = []
    lista_palavras = []

    # números aleatórios
    Util.popular_lista_numeros_aleatorios(lista_numeros, 10, 50, 100)
    Util.exibir_lista_numeros(lista_numeros)

    # palavras aleatórias
    Util.popular_lista_palavras_aleatorio(lista_palavras, 10, 10)
    Util.exibir_lista_palavras(lista_palavras)

    # salvar em arquivos
    Util.popular_lista_numeros_arquivo(lista_numeros, "numeros.txt")
    Util.popular_lista_palavras_arquivo(lista_palavras, "palavras.txt")


if __name__ == "__main__":
    main()
