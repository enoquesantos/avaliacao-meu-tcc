# Avaliação do meu TCC
### Implementação para avaliação utilizando as seguintes features:
    - Login do usuário
        - Inclui o logout e recuperação de senha
        - Inclui salvar o json contendo os dados do usuário pelo serviço REST
    - Visualização de mensagens com perfil aluno ou professor
        - A definição do perfil do usuário será feita mediante json enviado pelo webservice
        - As páginas devem ser exibidas a partir do perfil do usuário (teacher ou student)
    - Envio de mensagens usando o perfil 'Professor'
        - Inclui seleção de destinatário: turma específica ou todos os alunos
        - Ao selecionar uma turma específica, inclui escolha de uma turma
    - Visualização e Edição do perfil do usuário com permissão 'Professor'
        - Inclui apenas edição dos campos email e senha

#### Métricas utilizadas para compor a avaliação das implementações:
    - Número de linhas dos arquivos criados em cada versão (com e sem o framework)
    - Densidade de bugs por linha
    - Número de alterações efetuadas ao usar o framework

    - Para extrair as métricas de número de linhas dos arquivos:
        - Emile1: wc -l `find ~/qt/projects/avaliacao-tcc/Emile1/plugins -type f`
        - Emile2: wc -l `find ~/qt/projects/avaliacao-tcc/Emile2 -type f`
