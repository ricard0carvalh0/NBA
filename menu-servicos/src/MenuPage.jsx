
import { Database, Activity, Server, Cloud } from "lucide-react"

const services = [
  { name: "pgAdmin", href: "https://pg.akatsuco.com.br", icon: Database },
  { name: "Zabbix", href: "https://zabbix.akatsuco.com.br", icon: Activity },
  { name: "Temboard", href: "https://tb.akatsuco.com.br", icon: Server },
  { name: "Airflow", href: "https://airflow.akatsuco.com.br", icon: Cloud },
]

export default function MenuPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-100 via-white to-blue-50 flex flex-col items-center justify-center p-6">
      {/* Título e descrição */}
      <div className="text-center mb-12">
        <h1 className="text-4xl font-bold text-blue-800 mb-2">Painel de Serviços</h1>
        <p className="text-gray-600 text-lg">Ferramentas implementadas:</p>
        <br/>
      </div>

      {/* Menu horizontal */}
      <nav className="flex flex-row flex-wrap justify-center gap-12 bg-white rounded-2xl shadow-xl px-12 py-8 max-w-6xl w-full">
        {services.map(({ name, href, icon: Icon }) => (
          <a
            key={name}
            href={href}
            target="_blank"
            rel="noopener noreferrer"
            className="group flex flex-col items-center text-center text-gray-700 hover:text-blue-700 transition-transform duration-300 transform hover:scale-105 min-w-[120px]"
          >
            <Icon className="h-30 w-30 mb-4 text-blue-600 group-hover:text-blue-800 transition-colors duration-300" />
            <span className="text-lg font-semibold">{name}</span>
          </a>
        ))}
      </nav>
      <br/>
      {/* Rodapé */}
      <footer className="text-sm text-gray-500 mt-16">
        © 2025 CEFET-RJ | Administração de Banco de Dados
      </footer>
    </div>
  )
}


