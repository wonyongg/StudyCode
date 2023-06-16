import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
// import App from './App';
import reportWebVitals from './reportWebVitals';

// import Library from './chapter_03/Library';
// import Library from './chapter_04/Library';
// import CommentList from './chapter_05/CommentList';
// import NotificationList from './chapter_06/NotificationList';
// import Accommodate from './chapter_07/Accommodate';
import ConfirmButtonFunction from './chapter_08/ConfirmBUtton-function';

const root = ReactDOM.createRoot(document.getElementById('root')); 
// 리액트 18버전부터 렌더링 코딩 방식이 바뀜
root.render(
  <React.StrictMode>
    <ConfirmButtonFunction />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
