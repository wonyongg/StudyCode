import React from "react";

const students = [
    {
        id: 1, // id를 키 값으로 설정
        name: "Wonyong"
    },
    {
        id: 2,
        name: "Steve"
    },
    {
        id: 3,
        name: "Bill"
    },
    {
        id: 4,
        name: "Jeff"
    }
];

function AttendanceBook(props) {
    return (
        <ul>
            {students.map((student) => {
                return <li key={student.id}>{student.name}</li>;
            })}
        </ul>
    );
}

export default AttendanceBook;