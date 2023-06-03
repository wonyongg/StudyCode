import React from "react";
import Comment from "./Comment";

const comments = [
{
    name: "손흥민",
    comment: "레알마드리드로 이적할거야."
},
{
    name: "해리 케인",
    comment: "나는 맨유로 이적할거야.."
},
{
    name: "손흥민",
    comment: "안녕 잘가"
},
{
    name: "해리 케인",
    comment: "그래 너도"
},{
    name: "비니시우스 Jr",
    comment: "웰컴 쏘니. 레알마드리드에 온 걸 환영해!"
},
]



function CommentList(props) {
    return (
        <div>
            {
                comments.map((comment) => {
                    return (
                        <Comment name={comment.name} comment={comment.comment} />
                    );
                })
            }
        </div>
    );
}

export default CommentList;