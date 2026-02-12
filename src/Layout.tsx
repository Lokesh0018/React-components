import { Link, useNavigate } from "react-router-dom";
import { routes } from "./routes";
import "./Layout.css"; // This import is for side effects (CSS styles)

export const Layout = () => {
  const sortedRoutes = routes.sort((a, b) => {
    const regex = /^([a-zA-Z]+)(\d*)$/;

    const matchA = a.name.match(regex);
    const matchB = b.name.match(regex);

    const textA = matchA ? matchA[1] : a.name;
    const textB = matchB ? matchB[1] : b.name;
    const numA = matchA && matchA[2] ? parseInt(matchA[2], 10) : 0;
    const numB = matchB && matchB[2] ? parseInt(matchB[2], 10) : 0;

    const textCompare = textA.localeCompare(textB);
    if (textCompare !== 0) return textCompare;

    return numA - numB;
  });

  const navigate = useNavigate();

  return (
    <main className="layout">
      <header className="layout-header">
        <div className="content">
          <h2>
            <img src="/src/assets/Logo.jpg" alt="React Components Logo" className="logo" />
            <span>React Components</span>
          </h2>
        </div>
      </header>
      <div className="layout-card">
        <div className="layout-table-wrapper">
          <table className="layout-table">
            <thead>
              <tr>
                <th>Name</th>
              </tr>
            </thead>
            <tbody>
              {sortedRoutes.map((route) => (
                <tr onClick={() => navigate(route.path)} key={route.path}>
                  <td>
                    <Link to={route.path}>{route.name}</Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </main>
  );
};
