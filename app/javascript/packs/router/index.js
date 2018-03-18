
import Login from '../views/Login.vue'
import NotFound from '../views/404.vue'
import Home from '../views/Home.vue'
import Main from '../views/Main.vue'
import UserManage from '../views/skill/UserManage.vue'
import user from '../views/skill/User.vue'
import userMock from '../views/skill/userMock.vue'
import EmployeeDetail from '../views/skill/EmployeeDetail.vue'
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
            { path: '/editEmployee', component:EditEmployee, name:'スキルシート編集'}, 
        ]
    },
    {
        path: '/',
        component: Home,
        name: '',
        iconCls: 'fa fa-cog',
        leaf: true,//サブメニューなし
        children: [
            { path: '/table', component: UserManage, name: 'ユーザ管理' },
        ]
    },
    // {
    //     path: '/',
    //     component: Home,
    //     name: 'そのた',
    //     iconCls: 'el-icon-message',
    //     children: [
    //         { path: '/userMock', component: userMock, name: 'Mock版スキル検索' },
    //         { path: '/sandbox', component: Sandbox, name: 'お砂場' },
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
