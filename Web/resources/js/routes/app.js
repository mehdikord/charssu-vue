import { createRouter, createWebHistory } from "vue-router";
import Front_Index_Main from "../components/front/index/Front_Index_Main";
import Front_Orders_New from "../components/front/orders/Front_Orders_New";
import Front_Auth from "../components/front/auth/Front_Auth";
import Front_Shop_Index from "../components/front/shop/Front_Shop_Index";
import Front_Shop_Products_Single from "../components/front/shop/Front_Shop_Products_Single";


const routes = [

    {
        path : '/',
        component : Front_Index_Main,
        name : 'front_index',
    },
    {
        path : '/auth',
        component : Front_Auth,
        name : 'front_auth',
    },
    {
        path : '/orders/new',
        component : Front_Orders_New,
        name : 'front_orders_new',
    },
    {
        path : '/shop',
        component : Front_Shop_Index,
        name : 'front_shop',
    },
    {
        path : '/products/:code',
        component : Front_Shop_Products_Single,
        name : 'front_shop_products_single',
    },






];


export  const router = createRouter({
    history: createWebHistory(),
    routes: routes,
});
