import React from "react";
import { styled } from "styled-components";

// button 컴포넌트에 styled를 입힌 styledButton 컴포넌트
const StyledButton = styled.button`
    padding: 8px 16px;
    font-size: 16px;
    border-width: 1px;
    border-radius: 8px;
    cursor: pointer;
`;

function Button(props) {
    const { title, onClick } = props;
    // Button 컴포넌트에서 props로 받은 title이 Button 목록에 표시됨
    return <StyledButton onClick={onClick}>{title || "button"}</StyledButton>;
}

export default Button;