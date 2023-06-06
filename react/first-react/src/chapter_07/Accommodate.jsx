import React, { useState, useEffect } from "react";
import useCounter from "./useCounter";

const MAX_CAPACITY = 10;

function Accommodate(props) {
    const [isFull, setIsFull] = useState(false);
    const [count, increaseCount, decreaseCount] = useCounter(0);

    useEffect(() => { // 호출 이유 : 컴포넌트가 변경되었기 떄문
        console.log("============================");
        console.log("useEffect() is called.");
        console.log(`isFull: ${isFull}`);
    });// 의존성 배열  없음

    useEffect(() => { // 호출 이유 : 카운트 값이 변경되었기 때문
        setIsFull(count >= MAX_CAPACITY);
        console.log(`Current count value: ${count}`);
    }, [count]); // 의존성 배열 있음

    return (
        <div style={{ padding: 16}}>
            <p>{`총 ${count}명 수용했습니다.`}</p>

            <button onClick={increaseCount} disabled={isFull}>
                입장
            </button>
            <button onClick={decreaseCount}>퇴장</button>

            {isFull && <p style={{ color: "red" }}>정원이 가득 찼습니다.</p>}
        </div>
    );
}

export default Accommodate;