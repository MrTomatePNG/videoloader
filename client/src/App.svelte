<script>
    let menuEsquerdoAberto = false;
    let menuDireitoAberto = false;

    const fecharModais = () => {
        menuEsquerdoAberto = false;
        menuDireitoAberto = false;
    };
</script>

<main class="app-container">
    <button class="toggle-btn left" on:click={() => (menuEsquerdoAberto = true)}
        >☰</button
    >
    <button class="toggle-btn right" on:click={() => (menuDireitoAberto = true)}
        >💬</button
    >

    <aside class="area-ranking" class:active={menuEsquerdoAberto}>
        <div class="content ranking-comments">
            Ranking / Mais Comentados
            <button class="close-mobile" on:click={fecharModais}>&times;</button
            >
        </div>
        <div class="content options">Options / Support</div>
    </aside>

    <article class="area-main">
        <nav class="tabs">novidades / aleatorios / seguindo</nav>
        <div class="scroll-content">
            {#each Array(50) as _, i}
                <p>Postagem {i + 1}...</p>
            {/each}
        </div>
    </article>

    <aside class="area-notifications" class:active={menuDireitoAberto}>
        <div class="content">Pesquisa/Notificaçoes</div>
    </aside>

    <aside class="area-chats" class:active={menuDireitoAberto}>
        <div class="content">Chats / Grupos</div>
    </aside>

    {#if menuEsquerdoAberto || menuDireitoAberto}
        <div
            tabindex="0"
            role="button"
            class="overlay"
            on:click={fecharModais}
            on:keydown={(e) => {
                if (e.key === "Escape") fecharModais();
            }}
        ></div>
    {/if}
</main>

<style lang="scss">
    $gap: 3px;
    $bg-card: #121212;
    $border-color: red;
    $tablet: 1024px;
    $mobile: 768px;

    .app-container {
        display: grid;
        height: 100vh;
        width: 100vw;
        padding: $gap;
        gap: $gap;
        overflow: hidden;
        background-color: #000;
        box-sizing: border-box;

        // Desktop Layout
        grid-template-columns: 1fr 1.5fr 1fr;
        grid-template-rows: 1fr 3fr;
        grid-template-areas:
            "ranking   main   notif"
            "ranking   main   chats";

        @media (max-width: $tablet) {
            grid-template-columns: 100%;
            grid-template-rows: 100%;
            grid-template-areas: "main";
            padding: 0;
        }
    }

    aside,
    article {
        background: $bg-card;
        border: 1px solid $border-color;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    // Configuração das Áreas
    .area-ranking {
        grid-area: ranking;
        .ranking-comments {
            height: 60%;
            border-bottom: 1px solid $border-color;
            position: relative;
        }
    }

    .area-main {
        grid-area: main;
        border: 1px solid blue;
        display: flex;
        flex-direction: column;
        height: 100%; // Adicione isso para garantir que ela preencha o slot do grid
        min-height: 0; // Evita que o flexbox transborde o grid
    }

    .area-notifications {
        grid-area: notif;
    }

    .area-chats {
        grid-area: chats;
    }

    // --- SCROLL CONTENT ---
    .scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 10px 15px;

        p {
            margin: 10px 0;
            color: #ccc;
        }
    }

    // --- CONTEÚDO GENÉRICO ---
    .content {
        padding: 15px;
        overflow-y: auto;
        flex: 1;
        color: #ccc;

        &.ranking-comments {
            flex: initial;
            padding-bottom: 10px;
        }

        &.options {
            padding-top: 10px;
        }
    }

    // --- LÓGICA DE MODAL (TABLET/MOBILE) ---

    @media (max-width: $tablet) {
        aside {
            position: fixed;
            z-index: 1000;
            height: 100%;
            width: 280px;
        }

        .area-ranking {
            left: 0;
            top: 0;
            bottom: 0;
            transform: translateX(-100%);
            &.active {
                transform: translateX(0);
            }
        }

        .area-notifications {
            right: 0;
            top: 0;
            height: 40%;
            width: 300px;
            transform: translateX(100%);
            border-bottom: 1px solid $border-color;
            &.active {
                transform: translateX(0);
            }
        }

        .area-chats {
            right: 0;
            bottom: 0;
            height: 60%;
            width: 300px;
            transform: translateX(100%);
            border-top: 1px solid $border-color;
            &.active {
                transform: translateX(0);
            }
        }
    }

    // Elementos de interface mobile
    .toggle-btn {
        display: none;
        position: fixed;
        top: 10px;
        background: $border-color;
        color: white;
        border: none;
        padding: 8px 12px;
        z-index: 500;
        cursor: pointer;
        border-radius: 4px;
        font-size: 16px;

        @media (max-width: $tablet) {
            display: block;
        }

        &.left {
            left: 10px;
        }

        &.right {
            right: 10px;
        }

        &:hover {
            opacity: 0.8;
        }
    }

    .overlay {
        position: fixed;
        inset: 0;
        background: rgba(0, 0, 0, 0.8);
        z-index: 900;
    }

    .close-mobile {
        display: none;
        @media (max-width: $tablet) {
            display: block;
            position: absolute;
            right: 10px;
            top: 10px;
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;

            &:hover {
                opacity: 0.7;
            }
        }
    }

    // Conteúdo interno
    .area-main .tabs {
        padding: 15px;
        border-bottom: 1px solid $border-color;
        background: lighten($bg-card, 2%);
        font-weight: bold;
        color: #ccc;

        @media (max-width: $tablet) {
            padding-left: 60px;
            padding-right: 60px;
        }
    }
</style>
