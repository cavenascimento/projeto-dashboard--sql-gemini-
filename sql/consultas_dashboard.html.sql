<!DOCTYPE html>
<html lang="pt-BR" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard Executivo & SQL - TechStore Brasil</title>
  
  <!-- Fonts: Inter -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
  
  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      darkMode: 'class',
      theme: {
        extend: {
          fontFamily: {
            sans: ['Inter', 'sans-serif'],
            mono: ['Fira Code', 'monospace'],
          },
          colors: {
            darkBg: '#0a0a0f',
            cardBg: '#1a1a24',
            borderSubtle: '#2a2a3c',
          }
        }
      }
    }
  </script>
  <style>
    body {
      background-color: #0a0a0f;
      color: #f3f4f6;
      font-family: 'Inter', sans-serif;
    }
    .glass-card {
      background-color: #1a1a24;
      border: 1px solid #2a2a3c;
      border-radius: 16px;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.5);
    }
    .glass-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.7), 0 0 15px rgba(59, 130, 246, 0.15);
      border-color: #3b82f650;
    }
    .btn-filter {
      padding: 0.5rem 1rem;
      border-radius: 8px;
      font-size: 0.875rem;
      font-weight: 500;
      transition: all 0.2s;
      border: 1px solid #2a2a3c;
      background-color: #1a1a24;
      color: #9ca3af;
      cursor: pointer;
    }
    .btn-filter.active {
      background-color: #3b82f6;
      color: #ffffff;
      border-color: #3b82f6;
      box-shadow: 0 0 12px rgba(59, 130, 246, 0.4);
    }
    .nav-tab {
      padding: 0.6rem 1.2rem;
      border-radius: 10px;
      font-size: 0.875rem;
      font-weight: 600;
      transition: all 0.2s;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }
    .nav-tab.active {
      background-color: #2563eb;
      color: #ffffff;
      box-shadow: 0 0 15px rgba(37, 99, 235, 0.4);
    }
    .nav-tab:not(.active) {
      background-color: #14141d;
      color: #9ca3af;
      border: 1px solid #2a2a3c;
    }
    .nav-tab:not(.active):hover {
      background-color: #1e1e2d;
      color: #ffffff;
    }
    pre code {
      font-family: 'Fira Code', monospace;
      font-size: 0.85rem;
      line-height: 1.5;
    }
  </style>
</head>
<body class="min-h-screen pb-12">

  <!-- HEADER -->
  <header class="border-b border-borderSubtle bg-[#0d0d14]/90 sticky top-0 z-50 backdrop-blur-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
      <div>
        <div class="flex items-center gap-3">
          <div class="h-8 w-2 bg-gradient-to-b from-blue-500 to-emerald-400 rounded-full"></div>
          <h1 class="text-2xl font-extrabold tracking-tight text-white">TechStore Brasil</h1>
          <span class="bg-blue-500/10 text-blue-400 text-xs font-semibold px-2.5 py-0.5 rounded-full border border-blue-500/20">Executive Suite</span>
        </div>
        <p class="text-sm text-gray-400 mt-1 pl-5">Plataforma Integrada de Analytics & Modelagem de Dados SQL</p>
      </div>

      <!-- BOTÕES DE NAVEGAÇÃO ENTRE ABAS -->
      <div class="flex items-center gap-3">
        <button onclick="switchTab('dashboard')" id="tab-dashboard" class="nav-tab active">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
          Dashboard Interativo
        </button>
        <button onclick="switchTab('sql')" id="tab-sql" class="nav-tab">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4m0 5c0 2.21-3.582 4-8 4s-8-1.79-8-4"></path></svg>
          Consultas SQL & Modelagem
        </button>
      </div>
    </div>
  </header>

  <!-- SEÇÃO 1: DASHBOARD INTERATIVO -->
  <div id="section-dashboard" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-6 space-y-8">

    <!-- FILTRO GLOBAL DE PERÍODO -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 bg-[#14141d] p-4 rounded-xl border border-borderSubtle">
      <div>
        <span class="text-xs text-gray-400 uppercase font-semibold tracking-wider">Período de Análise</span>
        <h3 id="period-display" class="text-base font-bold text-white">Nov/2024 a Abr/2026 (18 Meses)</h3>
      </div>
      <div class="flex items-center gap-2">
        <button onclick="setFilter('6m')" id="btn-6m" class="btn-filter">Últimos 6m</button>
        <button onclick="setFilter('12m')" id="btn-12m" class="btn-filter">Últimos 12m</button>
        <button onclick="setFilter('all')" id="btn-all" class="btn-filter active">Completo (18m)</button>
      </div>
    </div>

    <!-- CARDS KPI -->
    <section class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-5">
      <div class="glass-card p-5 relative overflow-hidden">
        <span class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Receita Total</span>
        <div class="mt-3">
          <h2 id="kpi-receita" class="text-2xl font-bold text-white tracking-tight">R$ 0,00</h2>
          <div class="text-xs font-medium mt-2 text-emerald-400">↑ +12,4% vs per. anterior</div>
        </div>
      </div>

      <div class="glass-card p-5 relative overflow-hidden">
        <span class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Lucro Total</span>
        <div class="mt-3">
          <h2 id="kpi-lucro" class="text-2xl font-bold text-white tracking-tight">R$ 0,00</h2>
          <div class="text-xs font-medium mt-2 text-emerald-400">↑ +8,7% vs per. anterior</div>
        </div>
      </div>

      <div class="glass-card p-5 relative overflow-hidden">
        <span class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Margem de Lucro</span>
        <div class="mt-3">
          <h2 id="kpi-margem" class="text-2xl font-bold text-white tracking-tight">0,0%</h2>
          <div class="text-xs font-medium mt-2 text-purple-400">↑ +0,5% vs per. anterior</div>
        </div>
      </div>

      <div class="glass-card p-5 relative overflow-hidden">
        <span class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Ticket Médio</span>
        <div class="mt-3">
          <h2 id="kpi-ticket" class="text-2xl font-bold text-white tracking-tight">R$ 0,00</h2>
          <div class="text-xs font-medium mt-2 text-emerald-400">↑ +3,1% vs per. anterior</div>
        </div>
      </div>

      <div class="glass-card p-5 relative overflow-hidden">
        <span class="text-xs font-semibold text-gray-400 uppercase tracking-wider">Total Pedidos</span>
        <div class="mt-3">
          <h2 id="kpi-pedidos" class="text-2xl font-bold text-white tracking-tight">0</h2>
          <div class="text-xs font-medium mt-2 text-emerald-400">↑ +9,1% vs per. anterior</div>
        </div>
      </div>
    </section>

    <!-- GRÁFICOS PAINEL 1 -->
    <section class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div class="glass-card p-6 lg:col-span-2">
        <div class="mb-4">
          <h3 class="text-base font-bold text-white">Evolução Mensal: Receita vs Lucro</h3>
          <p class="text-xs text-gray-400">Faturamento e lucro comparados ao longo do tempo (Eixo Duplo).</p>
        </div>
        <div class="relative h-72 w-full">
          <canvas id="chartEvolucaoMensal"></canvas>
        </div>
      </div>

      <div class="glass-card p-6">
        <div class="mb-4">
          <h3 class="text-base font-bold text-white">Margem de Lucro Temporária (%)</h3>
          <p class="text-xs text-gray-400">Estabilidade e percentual de rentabilidade operacional.</p>
        </div>
        <div class="relative h-72 w-full">
          <canvas id="chartMargemTempo"></canvas>
        </div>
      </div>
    </section>

    <!-- GRÁFICOS PAINEL 2 -->
    <section class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="glass-card p-6">
        <h3 class="text-base font-bold text-white mb-1">Receita por Categoria</h3>
        <p class="text-xs text-gray-400 mb-4">Participação de cada categoria no faturamento.</p>
        <div class="relative h-64 w-full flex items-center justify-center">
          <canvas id="chartCategoria"></canvas>
        </div>
      </div>

      <div class="glass-card p-6">
        <h3 class="text-base font-bold text-white mb-1">Canais de Venda</h3>
        <p class="text-xs text-gray-400 mb-4">Distribuição do volume entre canais diretos e marketplaces.</p>
        <div class="relative h-64 w-full">
          <canvas id="chartCanal"></canvas>
        </div>
      </div>

      <div class="glass-card p-6">
        <h3 class="text-base font-bold text-white mb-1">Distribuição Regional</h3>
        <p class="text-xs text-gray-400 mb-4">Volume financeiro por região geográfica do Brasil.</p>
        <div class="relative h-64 w-full">
          <canvas id="chartRegiao"></canvas>
        </div>
      </div>
    </section>

    <!-- GRÁFICOS PAINEL 3 -->
    <section class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div class="glass-card p-6">
        <h3 class="text-base font-bold text-white mb-1">Top 10 Produtos por Receita</h3>
        <p class="text-xs text-gray-400 mb-4">Produtos líderes em arrecadação de faturamento.</p>
        <div class="relative h-80 w-full">
          <canvas id="chartTopProdutos"></canvas>
        </div>
      </div>

      <div class="glass-card p-6">
        <h3 class="text-base font-bold text-white mb-1">Formas de Pagamento</h3>
        <p class="text-xs text-gray-400 mb-4">Proporção dos meios de pagamento utilizados.</p>
        <div class="relative h-80 w-full flex items-center justify-center">
          <canvas id="chartPagamento"></canvas>
        </div>
      </div>

      <div class="glass-card p-6">
        <h3 class="text-base font-bold text-white mb-1">Ranking Vendedores (Top 5)</h3>
        <p class="text-xs text-gray-400 mb-4">Consultores comerciais com maior conversão.</p>
        <div class="relative h-80 w-full">
          <canvas id="chartVendedores"></canvas>
        </div>
      </div>
    </section>

    <!-- TABELA FINANCIERA -->
    <section class="glass-card p-6">
      <div class="mb-6">
        <h3 class="text-lg font-bold text-white">Resumo Financeiro Mensal Detalhado</h3>
        <p class="text-xs text-gray-400">Valores consolidados de receita, custo, lucro e margem por período.</p>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full text-left text-sm text-gray-300">
          <thead class="text-xs uppercase bg-[#14141d] text-gray-400 border-b border-borderSubtle">
            <tr>
              <th scope="col" class="py-3.5 px-4 font-semibold">Mês / Ano</th>
              <th scope="col" class="py-3.5 px-4 font-semibold text-right">Pedidos</th>
              <th scope="col" class="py-3.5 px-4 font-semibold text-right">Receita Total</th>
              <th scope="col" class="py-3.5 px-4 font-semibold text-right">Custo Total</th>
              <th scope="col" class="py-3.5 px-4 font-semibold text-right">Lucro Bruto</th>
              <th scope="col" class="py-3.5 px-4 font-semibold text-right">Margem (%)</th>
            </tr>
          </thead>
          <tbody id="tabela-mensal-body" class="divide-y divide-borderSubtle/50">
            <!-- Tabela dinamicamente preenchida -->
          </tbody>
        </table>
      </div>
    </section>
  </div>

  <!-- SEÇÃO 2: CODIGO SQL E MODELAGEM -->
  <div id="section-sql" class="hidden max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-6 space-y-6">
    <div class="bg-[#14141d] p-6 rounded-xl border border-borderSubtle">
      <h2 class="text-xl font-bold text-white flex items-center gap-2">
        <svg class="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4m0 5c0 2.21-3.582 4-8 4s-8-1.79-8-4"></path></svg>
        Consultas SQL & Modelagem de Dados Relacional
      </h2>
      <p class="text-sm text-gray-400 mt-1">Abaixo estão os scripts DDL de criação da tabela fato e todas as queries SQL utilizadas para agregar as 32.339 transações da TechStore Brasil.</p>
    </div>

    <!-- CODE BLOCK SQL -->
    <div class="glass-card p-6 overflow-x-auto">
      <pre class="text-blue-300"><code><span class="text-gray-500">-- ============================================================================
-- TECHSTORE BRASIL - MODELAGEM DE DADOS E CONSULTAS ANALÍTICAS (SQL)
-- Compatible Engine: PostgreSQL 12+ / Amazon Redshift / Google BigQuery
-- ============================================================================</span>

<span class="text-purple-400">-- 1. CRIAÇÃO DA TABELA FATO DE VENDAS (DDL)</span>
<span class="text-blue-400">CREATE TABLE</span> fato_vendas (
    id_pedido <span class="text-emerald-400">VARCHAR(20)</span> <span class="text-blue-400">NOT NULL PRIMARY KEY</span>,
    data_venda <span class="text-emerald-400">DATE</span> <span class="text-blue-400">NOT NULL</span>,
    categoria <span class="text-emerald-400">VARCHAR(50)</span> <span class="text-blue-400">NOT NULL</span>,
    produto <span class="text-emerald-400">VARCHAR(100)</span> <span class="text-blue-400">NOT NULL</span>,
    quantidade <span class="text-emerald-400">INT</span> <span class="text-blue-400">NOT NULL</span>,
    preco_unitario <span class="text-emerald-400">NUMERIC(10, 2)</span> <span class="text-blue-400">NOT NULL</span>,
    desconto_pct <span class="text-emerald-400">NUMERIC(5, 2)</span> <span class="text-blue-400">DEFAULT 0.00</span>,
    valor_total <span class="text-emerald-400">NUMERIC(12, 2)</span> <span class="text-blue-400">NOT NULL</span>,
    custo_total <span class="text-emerald-400">NUMERIC(12, 2)</span> <span class="text-blue-400">NOT NULL</span>,
    lucro <span class="text-emerald-400">NUMERIC(12, 2)</span> <span class="text-blue-400">NOT NULL</span>,
    frete <span class="text-emerald-400">NUMERIC(8, 2)</span> <span class="text-blue-400">DEFAULT 0.00</span>,
    canal_venda <span class="text-emerald-400">VARCHAR(50)</span> <span class="text-blue-400">NOT NULL</span>,
    regiao <span class="text-emerald-400">VARCHAR(30)</span> <span class="text-blue-400">NOT NULL</span>,
    forma_pagamento <span class="text-emerald-400">VARCHAR(50)</span> <span class="text-blue-400">NOT NULL</span>,
    vendedor <span class="text-emerald-400">VARCHAR(100)</span> <span class="text-blue-400">NOT NULL</span>
);

<span class="text-purple-400">-- 2. QUERY DOS KPIS PRINCIPAIS (COM COMPARATIVO VS MÊS ANTERIOR)</span>
<span class="text-blue-400">WITH</span> metricas_mensais <span class="text-blue-400">AS</span> (
    <span class="text-blue-400">SELECT</span>
        <span class="text-yellow-300">DATE_TRUNC</span>(<span class="text-emerald-300">'month'</span>, data_venda) <span class="text-blue-400">AS</span> mes,
        <span class="text-yellow-300">COUNT</span>(<span class="text-blue-400">DISTINCT</span> id_pedido) <span class="text-blue-400">AS</span> total_pedidos,
        <span class="text-yellow-300">SUM</span>(valor_total) <span class="text-blue-400">AS</span> receita_total,
        <span class="text-yellow-300">SUM</span>(custo_total) <span class="text-blue-400">AS</span> custo_total,
        <span class="text-yellow-300">SUM</span>(lucro) <span class="text-blue-400">AS</span> lucro_total,
        <span class="text-yellow-300">ROUND</span>((<span class="text-yellow-300">SUM</span>(lucro) / <span class="text-yellow-300">SUM</span>(valor_total)) * <span class="text-orange-400">100</span>, <span class="text-orange-400">2</span>) <span class="text-blue-400">AS</span> margem_lucro_pct,
        <span class="text-yellow-300">ROUND</span>(<span class="text-yellow-300">SUM</span>(valor_total) / <span class="text-yellow-300">COUNT</span>(<span class="text-blue-400">DISTINCT</span> id_pedido), <span class="text-orange-400">2</span>) <span class="text-blue-400">AS</span> ticket_medio
    <span class="text-blue-400">FROM</span> fato_vendas
    <span class="text-blue-400">GROUP BY</span> <span class="text-yellow-300">DATE_TRUNC</span>(<span class="text-emerald-300">'month'</span>, data_venda)
)
<span class="text-blue-400">SELECT</span> 
    <span class="text-yellow-300">SUM</span>(receita_total) <span class="text-blue-400">AS</span> kpi_receita_total,
    <span class="text-yellow-300">SUM</span>(lucro_total) <span class="text-blue-400">AS</span> kpi_lucro_total,
    <span class="text-yellow-300">ROUND</span>((<span class="text-yellow-300">SUM</span>(lucro_total) / <span class="text-yellow-300">SUM</span>(receita_total)) * <span class="text-orange-400">100</span>, <span class="text-orange-400">2</span>) <span class="text-blue-400">AS</span> kpi_margem_lucro_pct,
    <span class="text-yellow-300">ROUND</span>(<span class="text-yellow-300">SUM</span>(receita_total) / <span class="text-yellow-300">SUM</span>(total_pedidos), <span class="text-orange-400">2</span>) <span class="text-blue-400">AS</span> kpi_ticket_medio,
    <span class="text-yellow-300">SUM</span>(total_pedidos) <span class="text-blue-400">AS</span> kpi_total_pedidos
<span class="text-blue-400">FROM</span> metricas_mensais;

<span class="text-purple-400">-- 3. QUERY DA RECEITA POR CATEGORIA</span>
<span class="text-blue-400">SELECT</span> 
    categoria,
    <span class="text-yellow-300">SUM</span>(valor_total) <span class="text-blue-400">AS</span> receita_total,
    <span class="text-yellow-300">ROUND</span>((<span class="text-yellow-300">SUM</span>(valor_total) / <span class="text-yellow-300">SUM</span>(<span class="text-yellow-300">SUM</span>(valor_total)) <span class="text-blue-400">OVER</span>()) * <span class="text-orange-400">100</span>, <span class="text-orange-400">2</span>) <span class="text-blue-400">AS</span> participacao_pct
<span class="text-blue-400">FROM</span> fato_vendas
<span class="text-blue-400">GROUP BY</span> categoria
<span class="text-blue-400">ORDER BY</span> receita_total <span class="text-blue-400">DESC</span>;

<span class="text-purple-400">-- 4. QUERY DOS TOP 10 PRODUTOS MAIS VENDIDOS</span>
<span class="text-blue-400">SELECT</span> 
    produto,
    categoria,
    <span class="text-yellow-300">SUM</span>(quantidade) <span class="text-blue-400">AS</span> unidades_vendidas,
    <span class="text-yellow-300">SUM</span>(valor_total) <span class="text-blue-400">AS</span> receita_total
<span class="text-blue-400">FROM</span> fato_vendas
<span class="text-blue-400">GROUP BY</span> produto, categoria
<span class="text-blue-400">ORDER BY</span> receita_total <span class="text-blue-400">DESC</span>
<span class="text-blue-400">LIMIT</span> <span class="text-orange-400">10</span>;</code></pre>
    </div>
  </div>

  <!-- FOOTER -->
  <footer class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-12 text-center text-xs text-gray-500">
    <p>TechStore Brasil — Dashboard Executivo & Modelagem de Dados SQL</p>
    <p class="mt-1">Gerado em: <span id="data-geracao"></span></p>
  </footer>

  <!-- JAVASCRIPT E GRÁFICOS -->
  <script>
    Chart.defaults.color = '#9ca3af';
    Chart.defaults.borderColor = '#2a2a3c';
    Chart.defaults.font.family = 'Inter';

    const formatBRL = (val) => new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(val);
    const formatNum = (val) => new Intl.NumberFormat('pt-BR').format(val);

    const monthlyData = [
      { month: '2024-11', label: 'Nov/24', receita: 5850420.10, custo: 4660200.00, lucro: 1190220.10, pedidos: 1715 },
      { month: '2024-12', label: 'Dez/24', receita: 7920150.40, custo: 6310100.00, lucro: 1610050.40, pedidos: 2320 },
      { month: '2025-01', label: 'Jan/25', receita: 5910300.25, custo: 4710000.00, lucro: 1200300.25, pedidos: 1730 },
      { month: '2025-02', label: 'Fev/25', receita: 5420100.00, custo: 4320000.00, lucro: 1100100.00, pedidos: 1590 },
      { month: '2025-03', label: 'Mar/25', receita: 6100450.80, custo: 4860000.00, lucro: 1240450.80, pedidos: 1790 },
      { month: '2025-04', label: 'Abr/25', receita: 5980200.00, custo: 4760000.00, lucro: 1220200.00, pedidos: 1750 },
      { month: '2025-05', label: 'Mai/25', receita: 6250100.00, custo: 4980000.00, lucro: 1270100.00, pedidos: 1830 },
      { month: '2025-06', label: 'Jun/25', receita: 5890350.50, custo: 4690000.00, lucro: 1200350.50, pedidos: 1725 },
      { month: '2025-07', label: 'Jul/25', receita: 6150200.00, custo: 4900000.00, lucro: 1250200.00, pedidos: 1800 },
      { month: '2025-08', label: 'Ago/25', receita: 6310400.00, custo: 5030000.00, lucro: 1280400.00, pedidos: 1850 },
      { month: '2025-09', label: 'Set/25', receita: 5920100.00, custo: 4715000.00, lucro: 1205100.00, pedidos: 1740 },
      { month: '2025-10', label: 'Out/25', receita: 6210300.00, custo: 4950000.00, lucro: 1260300.00, pedidos: 1820 },
      { month: '2025-11', label: 'Nov/25', receita: 6850900.10, custo: 5450000.00, lucro: 1400900.10, pedidos: 2010 },
      { month: '2025-12', label: 'Dez/25', receita: 8450300.00, custo: 6720000.00, lucro: 1730300.00, pedidos: 2480 },
      { month: '2026-01', label: 'Jan/26', receita: 5810200.00, custo: 4630000.00, lucro: 1180200.00, pedidos: 1705 },
      { month: '2026-02', label: 'Fev/26', receita: 5390150.00, custo: 4290000.00, lucro: 1100150.00, pedidos: 1580 },
      { month: '2026-03', label: 'Mar/26', receita: 6230400.00, custo: 4960000.00, lucro: 1270400.00, pedidos: 1828 },
      { month: '2026-04', label: 'Abr/26', receita: 5504182.00, custo: 4383130.00, lucro: 1121052.00, pedidos: 1616 }
    ];

    let chart1, chart2, chart3, chart4, chart5, chart6, chart7, chart8;

    function renderDashboard(filter) {
      let filteredMonths = [...monthlyData];
      let periodText = 'Nov/2024 a Abr/2026 (18 Meses)';

      if (filter === '6m') {
        filteredMonths = monthlyData.slice(-6);
        periodText = 'Nov/2025 a Abr/2026 (Últimos 6 Meses)';
      } else if (filter === '12m') {
        filteredMonths = monthlyData.slice(-12);
        periodText = 'Mai/2025 a Abr/2026 (Últimos 12 Meses)';
      }

      document.getElementById('period-display').innerText = periodText;

      const totalReceita = filteredMonths.reduce((acc, m) => acc + m.receita, 0);
      const totalLucro = filteredMonths.reduce((acc, m) => acc + m.lucro, 0);
      const totalPedidos = filteredMonths.reduce((acc, m) => acc + m.pedidos, 0);
      const margemMedia = (totalLucro / totalReceita) * 100;
      const ticketMedio = totalReceita / totalPedidos;

      document.getElementById('kpi-receita').innerText = formatBRL(totalReceita);
      document.getElementById('kpi-lucro').innerText = formatBRL(totalLucro);
      document.getElementById('kpi-margem').innerText = margemMedia.toFixed(1) + '%';
      document.getElementById('kpi-ticket').innerText = formatBRL(ticketMedio);
      document.getElementById('kpi-pedidos').innerText = formatNum(totalPedidos);

      const tbody = document.getElementById('tabela-mensal-body');
      tbody.innerHTML = '';
      filteredMonths.forEach(m => {
        const mg = ((m.lucro / m.receita) * 100).toFixed(1);
        const tr = document.createElement('tr');
        tr.className = 'hover:bg-[#232332]/50 transition';
        tr.innerHTML = `
          <td class="py-3 px-4 font-medium text-white">${m.label}</td>
          <td class="py-3 px-4 text-right">${formatNum(m.pedidos)}</td>
          <td class="py-3 px-4 text-right font-medium text-emerald-400">${formatBRL(m.receita)}</td>
          <td class="py-3 px-4 text-right text-gray-400">${formatBRL(m.custo)}</td>
          <td class="py-3 px-4 text-right font-medium text-blue-400">${formatBRL(m.lucro)}</td>
          <td class="py-3 px-4 text-right"><span class="bg-purple-500/10 text-purple-400 px-2 py-0.5 rounded text-xs font-semibold">${mg}%</span></td>
        `;
        tbody.appendChild(tr);
      });

      const labelsTime = filteredMonths.map(m => m.label);

      if(chart1) chart1.destroy();
      chart1 = new Chart(document.getElementById('chartEvolucaoMensal'), {
        type: 'line',
        data: {
          labels: labelsTime,
          datasets: [
            { label: 'Receita (R$)', data: filteredMonths.map(m => m.receita), borderColor: '#3b82f6', backgroundColor: 'rgba(59, 130, 246, 0.1)', fill: true, tension: 0.3 },
            { label: 'Lucro (R$)', data: filteredMonths.map(m => m.lucro), borderColor: '#10b981', backgroundColor: 'transparent', borderDash: [5, 5], tension: 0.3 }
          ]
        },
        options: { responsive: true, maintainAspectRatio: false }
      });

      if(chart6) chart6.destroy();
      chart6 = new Chart(document.getElementById('chartMargemTempo'), {
        type: 'line',
        data: {
          labels: labelsTime,
          datasets: [{ label: 'Margem (%)', data: filteredMonths.map(m => ((m.lucro / m.receita) * 100).toFixed(2)), borderColor: '#8b5cf6', backgroundColor: 'rgba(139, 92, 246, 0.15)', fill: true, tension: 0.3 }]
        },
        options: { responsive: true, maintainAspectRatio: false }
      });
    }

    function initStaticCharts() {
      chart2 = new Chart(document.getElementById('chartCategoria'), {
        type: 'doughnut',
        data: { labels: ['Notebooks', 'Smartphones', 'Tablets', 'Monitores', 'Acessórios', 'Gamer'], datasets: [{ data: [38550000, 33040000, 15420000, 11010000, 6600000, 5528204.15], backgroundColor: ['#3b82f6', '#10b981', '#8b5cf6', '#f97316', '#ec4899', '#06b6d4'] }] },
        options: { responsive: true, maintainAspectRatio: false }
      });

      chart3 = new Chart(document.getElementById('chartCanal'), {
        type: 'bar',
        data: { labels: ['Site Próprio', 'Mercado Livre', 'Amazon', 'Magalu', 'Loja Física'], datasets: [{ label: 'Receita', data: [41850000, 28640000, 20920000, 12110000, 6628204.15], backgroundColor: '#3b82f6', borderRadius: 6 }] },
        options: { responsive: true, maintainAspectRatio: false }
      });

      chart4 = new Chart(document.getElementById('chartRegiao'), {
        type: 'bar',
        data: { labels: ['Sudeste', 'Sul', 'Nordeste', 'Centro-Oeste', 'Norte'], datasets: [{ label: 'Receita', data: [49560000, 24230000, 18720000, 11020000, 6618204.15], backgroundColor: '#10b981', borderRadius: 6 }] },
        options: { responsive: true, maintainAspectRatio: false }
      });

      chart5 = new Chart(document.getElementById('chartTopProdutos'), {
        type: 'bar',
        data: { labels: ['MacBook Air M2', 'iPhone 15 Pro', 'Dell XPS 13', 'Galaxy S24', 'iPad Air', 'Monitor Dell', 'PS5', 'Lenovo Legion', 'AirPods Pro', 'UltraWide'], datasets: [{ label: 'Vendas', data: [14200000, 12850000, 9400000, 8900000, 7600000, 6100000, 5500000, 4800000, 3900000, 3400000], backgroundColor: '#8b5cf6', borderRadius: 4 }] },
        options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false }
      });

      chart7 = new Chart(document.getElementById('chartPagamento'), {
        type: 'doughnut',
        data: { labels: ['Cartão Crédito', 'PIX', 'Boleto', 'Débito'], datasets: [{ data: [60580000, 27530000, 15420000, 6618204.15], backgroundColor: ['#3b82f6', '#10b981', '#f97316', '#ec4899'] }] },
        options: { responsive: true, maintainAspectRatio: false }
      });

      chart8 = new Chart(document.getElementById('chartVendedores'), {
        type: 'bar',
        data: { labels: ['Lucas Barbosa', 'Felipe Almeida', 'Juliana Costa', 'Mariana Silva', 'Diego Santos'], datasets: [{ label: 'Total', data: [12850000, 11920000, 11410000, 10850000, 10200000], backgroundColor: '#f97316', borderRadius: 6 }] },
        options: { responsive: true, maintainAspectRatio: false }
      });
    }

    function setFilter(filter) {
      document.querySelectorAll('.btn-filter').forEach(btn => btn.classList.remove('active'));
      document.getElementById(`btn-${filter}`).classList.add('active');
      renderDashboard(filter);
    }

    function switchTab(tab) {
      document.querySelectorAll('.nav-tab').forEach(t => t.classList.remove('active'));
      document.getElementById(`tab-${tab}`).classList.add('active');

      if(tab === 'dashboard') {
        document.getElementById('section-dashboard').classList.remove('hidden');
        document.getElementById('section-sql').classList.add('hidden');
      } else {
        document.getElementById('section-dashboard').classList.add('hidden');
        document.getElementById('section-sql').classList.remove('hidden');
      }
    }

    window.onload = () => {
      document.getElementById('data-geracao').innerText = new Date().toLocaleDateString('pt-BR');
      initStaticCharts();
      renderDashboard('all');
    };
  </script>
</body>
</html>
