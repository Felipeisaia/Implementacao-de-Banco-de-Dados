#include <iostream>
#include <vector>
#include <algorithm> 
#include <ctime>
#include <cstdlib>   
#include "Util.h"
#include "Ordenacao.h"

using namespace std;

int main() {
    srand(time(0));

    vector<int> lista_bolha;
    vector<int> lista_normal;
    vector<int> lista_selecao;
    vector<int> lista_insercao;

    // Popular listas
    popular_lista(lista_bolha, 1000, 100, 20000);
    popular_lista(lista_normal, 1000, 100, 20000);
    popular_lista(lista_selecao, 1000, 100, 20000);
    popular_lista(lista_insercao, 1000, 100, 20000);

    // Ordenação nativa
    clock_t inicio = clock();
    sort(lista_normal.begin(), lista_normal.end());
    clock_t fim = clock();
    cout << "Tempo sort nativo: " << (float)(fim - inicio)/CLOCKS_PER_SEC << " s\n";

    // Bolha
    int comparacoes, trocas;
    inicio = clock();
    bolha(lista_bolha, comparacoes, trocas);
    fim = clock();
    cout << "Bolha - tempo: " << (float)(fim - inicio)/CLOCKS_PER_SEC
         << " s, comparacoes: " << comparacoes
         << ", trocas: " << trocas << endl;

    // Seleção
    inicio = clock();
    selecao(lista_selecao, comparacoes, trocas);
    fim = clock();
    cout << "Selecao - tempo: " << (float)(fim - inicio)/CLOCKS_PER_SEC
         << " s, comparacoes: " << comparacoes
         << ", trocas: " << trocas << endl;

    // Inserção
    inicio = clock();
    insercao(lista_insercao, comparacoes, trocas);
    fim = clock();
    cout << "Insercao - tempo: " << (float)(fim - inicio)/CLOCKS_PER_SEC
         << " s, comparacoes: " << comparacoes
         << ", trocas: " << trocas << endl;

    return 0;
}
