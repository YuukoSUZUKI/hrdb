
import Login from '../views/Login.vue'
import NotFound from '../views/404.vue'
import Home from '../views/Home.vue'
import Main from '../views/Main.vue'
import UserManage from '../views/skill/UserManage.vue'
import Form from '../views/skill/Form.vue'
import user from '../views/skill/User.vue'
import userMock from '../views/skill/userMock.vue'
import EmployeeDetail from '../views/skill/EmployeeDetail.vue'
// import Page4 from '../views/nav2/Page4.vue'
import Page5 from '../views/nav2/Page5.vue'
import Page6 from '../views/nav3/Page6.vue'
import echarts from '../views/report/echarts.vue'
import EditEmployee from '../views/skill/EditEmployee.vue'
import Sandbox from '../views/nav2/Sandbox.vue'

let routes = [
    {
        path: '/login',
        component: Login,
        name: '',
        hidden: true
    },
    {
        path: '/404',
        component: NotFound,
        name: '',
        hidden: true
    },
    //{ path: '/main', component: Main },
    {
        path: '/',
        component: Home,
        name: 'スキルシート',
        iconCls: 'fa fa-id-card-o',
        children: [
            { path: '/main', component: Main, name: 'メイン', hidden: true },
            { path: '/user', component: user, name: 'スキル検索' },
            { path: '/form', component: Form, name: 'スキルシート編集' },
            { path: '/editEmployee/1/edit', component:EditEmployee, name:'社員情報編集'}, // TODO:仮に固定値を入れる。本当はログインユーザのIDを入れる。
        ]
    },
    {
        path: '/',
        component: Home,
        name: 'メンテナンス',
        iconCls: 'fa fa-cog',
        children: [
            { path: '/table', component: UserManage, name: 'ユーザ管理' },
        ]
    },
    {
        path: '/',
        component: Home,
        name: 'そのた',
        iconCls: 'el-icon-message',
        children: [
            { path: '/userMock', component: userMock, name: 'Mock版スキル検索' },
            { path: '/sandbox', component: Sandbox, name: 'お砂場' },
        ]
    },

    
    // {
    //     path: '/',
    //     component: Home,
    //     name: 'ナビゲーション2',
    //     iconCls: 'el-icon-message',//图标样式class
    //     children: [
    //         // { path: '/page4', component: Page4, name: '页面4' },
    //         { path: '/page5', component: Page5, name: 'ページ5' }
    //     ]
    // },
    // {
    //     path: '/',
    //     component: Home,
    //     name: '',
    //     iconCls: 'fa fa-address-card',
    //     leaf: true,//サブメニューなし
    //     children: [
    //         { path: '/page6', component: Page6, name: 'ナビゲーション3' }
    //     ]
    // },
    {
        path: '/',
        component: Home,
        name: 'レポート',
        iconCls: 'fa fa-bar-chart',
        children: [
            { path: '/echarts', component: echarts, name: 'スキル別人数分布' }
        ]
    },
    {
        path: '*',
        hidden: true,
        redirect: { path: '/404' }
    }
];

export default routes;
