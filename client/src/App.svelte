<script>
    // Aqui você pode definir estados para o conteúdo de cada box
    // Estados para controlar os modais no Mobile/Tablet
    let menuEsquerdoAberto = false;
    let menuDireitoAberto = false;

    // Função simples para fechar tudo ao clicar fora (no overlay)
    const fecharModais = () => {
        menuEsquerdoAberto = false;
        menuDireitoAberto = false;
    };
</script>

<main class="app-container">
    <aside class="area-ranking">
        <div class="content ranking-comments">Ranking / Mais Comentados</div>
        <div class="content options">Options / Support</div>
    </aside>

    <article class="area-main">
        <nav class="tabs">novidades / aleatorios / seguindo</nav>
        <div class="scroll-content">Conteúdo scrolável aqui...</div>
    </article>

    <aside class="area-notifications">
        <div class="content">Notificações</div>
    </aside>

    <aside class="area-chats">
        <div class="content">Chats / Grupos</div>
    </aside>
</main>

<style lang="scss">
    // Variáveis para manter o padrão
    $gap: 3px;
    $border-radius: 0;
    $bg-card: #121212;
    $border-color: red;

    .app-container {
        // 1. Ocupa a tela toda e trava o scroll
        display: grid;
        height: 100vh;
        width: 100vw;
        padding: $gap;
        gap: $gap;
        overflow: hidden; // Garante que a página não scrolle
        background-color: #000;
        box-sizing: border-box;

        // 2. Definindo 3 colunas e 2 linhas
        // Colunas: laterais fixas e centro flexível (1fr)
        grid-template-columns: 300px 1fr 300px;
        grid-template-rows: 1fr 12fr;

        // 3. O "Mapa" do seu desenho
        grid-template-areas:
            "ranking   main   notif"
            "ranking      main   chats";
    }

    // Estilo comum para as caixas (Wireframe)
    aside,
    article {
        background: $bg-card;
        border: 1px solid $border-color;
        border-radius: $border-radius;
        display: flex;
        flex-direction: column;
        overflow: hidden; // Importante para o conteúdo interno não vazar
    }

    // Atribuindo cada classe à sua área no mapa
    .area-ranking {
        grid-area: ranking;
        .ranking-comments {
            height: 60%;
            border-bottom: 1px solid $border-color;
        }
        .options {
            display: flex;
        }
    }
    .area-user {
        grid-area: user;
    }
    .area-main {
        grid-area: main;
    }
    .area-notifications {
        grid-area: notif;
    }
    .area-chats {
        grid-area: chats;
    }

    // Configurando o scroll interno do centro
    .area-main {
        .tabs {
            padding: 15px;
            border-bottom: 1px solid $border-color;
            background: lighten($bg-card, 2%);
        }
        .scroll-content {
            flex: 1; // Ocupa todo o resto da altura
            overflow-y: auto; // Só aqui tem scroll!
            padding: 20px;
        }
    }
</style>
