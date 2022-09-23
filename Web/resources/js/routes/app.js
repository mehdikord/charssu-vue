import { createRouter, createWebHistory } from "vue-router";
import Front_Index_Main from "../components/front/index/Front_Index_Main";
import Front_Orders_New from "../components/front/orders/Front_Orders_New";
import Front_Auth from "../components/front/auth/Front_Auth";
import Front_Shop_Index from "../components/front/shop/Front_Shop_Index";
import Front_Shop_Products_Single from "../components/front/shop/Front_Shop_Products_Single";
import Front_Shop_Checkout from "../components/front/shop/Front_Shop_Checkout";
import Customer_Main from "../components/front/panel/Customer_Main";
import Customer_Profile from "../components/front/panel/Customer_Profile";


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
    {
        path : '/shop/checkout',
        component : Front_Shop_Checkout,
        name : 'front_shop_checkout',
    },
    {
        path : '/shop/checkout',
        component : Front_Shop_Checkout,
        name : 'front_shop_checkout',
    },

    //Customer Panel Routes
    {
        path : '/panel',
        component : Customer_Main,
        children : [
            {
                path : 'profile',
                component : Customer_Profile,
                name : 'customer_profile',

            }
        ]
    }






];


export  const router = createRouter({
    history: createWebHistory(),
    routes: routes,
});

