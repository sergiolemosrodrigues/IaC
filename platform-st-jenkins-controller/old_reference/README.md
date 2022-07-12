# OBS

Essa pasta foi criada para manter como referência o código original do jenkins utilizando Instance Group Manager (IGM / ou MIG - Managed Instance Grgou).

Essa idéia foi abandonada nesse momento pois o instancias em um IGM tem algumas limitações que não quis lidar agora:

1. Não permitem start/stop manual
2. Não é possível utilizar discos read/write quando o IGM possui um autoscaler

No momento atual do projeto, você manter uma instância com baixo uso initerruptamente é o maior impacto, além da dificuldade que esta sendo no momento em entender como gerar via terraform um IGM stateful (vários erros ocorrendo ao criar o disco e relacionar ao instance tempalte).

Dado o cenário, vamos utilizar um resource google_compute_instance_from_template para facilitar/agilizar o processo.

A stack do nexus evoluiu um pouco mais e o código pode apresentar algumas diferenças que podem ser úteis, já que ambas atendem o mesmo proposito.