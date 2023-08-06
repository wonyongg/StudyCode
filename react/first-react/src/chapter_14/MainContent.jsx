import { useContext } from "react";
import ThemeContext from "./ThemeContext";

function MainContent(props) {
    const { theme, toggleTheme } = useContext(ThemeContext);

    return (
        <div
            style={{
                width: "100vw",
                height: "100vh",
                padding: "1.5rem",
                backgroundColor: theme === "light" ? "white" : "black",
                color: theme === "light" ? "black" : "white"
            }}
        >
            <p>안녕하새요. 테마를 변경할 수 있는 웹사이트입니다.</p>
            <button onClick={toggleTheme}>테마 변경</button>
        </div>
    );
}

export default MainContent;