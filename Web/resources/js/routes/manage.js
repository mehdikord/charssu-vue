import { createRouter, createWebHistory } from "vue-router";
import Manage_Dashboard from "../components/management/dashboard/Manage_Dashboard";
import Manage_Users from "../components/management/users/Manage_Users";
import Manage_Zones from "../components/management/zones/Manage_Zones";
import Manage_Customers from "../components/management/customers/Manage_Customers";
import Manage_Serviceman_Create from "../components/management/servicemans/Manage_Serviceman_Create";
import Manage_Servicemans from "../components/management/servicemans/Manage_Servicemans";
import Manage_Servicemans_Edit from "../components/management/servicemans/Manage_Servicemans_Edit";
import Manage_Devices_Brands from "../components/management/devices/Manage_Devices_Brands";

const routes = [

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
        path : '/management/zones',
        component : Manage_Zones,
        name : 'manage_zones',
    },

    {
        path : '/management/devices/brands',
        component : Manage_Devices_Brands,
        name : 'manage_devices_brands',
    },



];

export default createRouter({
    history: createWebHistory(),
    routes: routes,
});
