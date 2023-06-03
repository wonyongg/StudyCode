import React from "react";
import Notification from "./Notification";

const reservedNotifications = [
    {
        id: 1,
        message: "인녕하세요. 오늘 일정을 알려드립니다."
    },
    {
        id: 2,
        message: "점심식사 시간입니다."
    },
    {
        id: 3,
        message: "이제 곧 미팅이 시작됩니다."
    }
];

var timer;

class NotificationList extends React.Component {
    constructor(props) {
        super(props);

        this.state = { 
            notifications: [], // 생성자에서는 앞으로 사용할 데이터를 state에 넣고 초기화한다.
        };
    }

    componentDidMount() {
        const { notifications } = this.state;
        timer = setInterval(() => {
            if (notifications.length < reservedNotifications.length) {
                const index = notifications.length;
                notifications.push(reservedNotifications[index]);
                this.setState({ // setState 함수로 state 업데이트
                    notifications: notifications
                });
            } else {
                this.setState ({ // 알림 추가가 모두 끝나면 모든 컴포넌트를 Unmount 시킴
                    notifications: [],
                });
                clearInterval(timer);
            }
        }, 1000);
    }

    render() {
        return (
            <div>
                {this.state.notifications.map((notification) => {
                    return (
                        <Notification 
                            key={notification.id}
                            id={notification.id}
                            message = {notification.message} 
                        />
                    );
                })}
            </div>
        );
    }
}

export default NotificationList;