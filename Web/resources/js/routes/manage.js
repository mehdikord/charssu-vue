import { createRouter, createWebHistory } from "vue-router";
import Manage_Dashboard from "../components/management/dashboard/Manage_Dashboard";
import Manage_Users from "../components/management/users/Manage_Users";
import Manage_Zones from "../components/management/zones/Manage_Zones";
import Manage_Customers from "../components/management/customers/Manage_Customers";
import Manage_Serviceman_Create from "../components/management/servicemans/Manage_Serviceman_Create";
import Manage_Servicemans from "../components/management/servicemans/Manage_Servicemans";
import Manage_Servicemans_Edit from "../components/management/servicemans/Manage_Servicemans_Edit";
import Manage_Devices_Brands from "../components/management/devices/Manage_Devices_Brands";
import Manage_Devices from "../components/management/devices/Manage_Devices";
import Manage_Problems from "../components/management/problems/Manage_Problems";
import Manage_Servicemans_Waiting from "../components/management/servicemans/Manage_Servicemans_Waiting";
import Manage_Auth from "../components/management/auth/Manage_Auth";
import Manage_Products_Categories from "../components/management/products/Manage_Products_Categories";
import Manage_Products from "../components/management/products/Manage_Products";
import Manage_Costs from "../components/management/costs/Manage_Costs";

const routes = [

    {
        path : '/management/auth',
        component : Manage_Auth,
        name : 'manage_auth',
    },
    {
        path : '/management/dashboard',
        component : Manage_Dashboard,
        name : 'manage_dashboard',
    },
    {
        path : '/management/users',
        component : Manage_Users,
        name : 'manage_users',
    },
    {
        path : '/management/customers',
        component : Manage_Customers,
        name : 'manage_customers',
    },
    {
        path : '/management/servicemans/create',
        component : Manage_Serviceman_Create,
        name : 'manage_servicemans_create',
    },
    {
        path : '/management/servicemans',
        component : Manage_Servicemans,
        name : 'manage_servicemans',
    },
    {
        path : '/management/servicemans/edit/:id',
        component : Manage_Servicemans_Edit,
        name : 'manage_servicemans_edit',
    },
    {
        path : '/management/servicemans/waiting',
        component : Manage_Servicemans_Waiting,
        name : 'manage_servicemans_waiting',
    },

    {
        path : '/management/zones',
        component : Manage_Zones,
        name : 'manage_zones',
    },

    {
        path : '/management/devices/brands',
        component : Manage_Devices_Brands,
        name : 'manage_devices_brands',
    },

    {
        path : '/management/devices',
        component : Manage_Devices,
        name : 'manage_devices',
    },

    {
        path : '/management/problems',
        component : Manage_Problems,
        name : 'manage_problems',
    },
    {
        path : '/management/products/categories',
        component : Manage_Products_Categories,
        name : 'manage_products_categories',
    },
    {
        path : '/management/products',
        component : Manage_Products,
        name : 'manage_products',
    },
    {
        path : '/management/costs',
        component : Manage_Costs,
        name : 'manage_costs',
    },



];


export  const router = createRouter({
    history: createWebHistory(),
    routes: routes,
});



