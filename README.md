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

#### Alterações realizadas na versão com o framework:
    Realizado o clone do projeto da arquitetura para o computador que será utilizado
    Pasta do projeto foi renomeada para Emile1
    Arquivo do projeto tcc.pro foi renomeado para Emile1
    Plugin About, AddPageDynamiccally e Pages disponibilizados como exemplo foram deletados
    Arquivo Listener1.qml foi deletado, pois não é necessário
    Arquivo em Listeners/config.json foi modificado, removendo uma linha do arquivo
    Adicionado a pasta 'Mensagens' para implementação da feature de mensagens (exibição e envio)
    Adicionado o arquivo config.json na pasta do plugin 'Mensagens'
    Adicionado os arquivos: 'SelectDestination.qml', 'SendMessages.qml' e 'ViewMessages.qml'
    Alterado o arquivo config.json e adicionado as páginas visíveis do plugin
    Adicionado o arquivo 'MessageDelegate.qml' como delegate da página 'ViewMessages.qml'
    Alterado a propriedade 'order' do plugin 'UserProfile' para o valor '5' para que fique abaixo das opções de envio e visualização de mensagens
    Removido as strings presente na propriedade 'roles' do plugin 'UserProfile' e mantido somente o valor 'teacher'
    Removido as strings presente na propriedade 'roles' do plugin 'Login' e mantido somente o valor 'teacher'