<template>
    <index_topbanner class="app-fade-in"></index_topbanner>
    <index_features class="app-fade-in"></index_features>
    <index_services_count class="app-fade-in"></index_services_count>
    <index_store class="app-fade-in"></index_store>
    <index_top_servicemans class="app-fade-in"></index_top_servicemans>
    <index_contact class="app-fade-in"></index_contact>
</template>

<script>
import Front_Index_Topbanner from "./Front_Index_Topbanner";
import Front_Index_Features from "./Front_Index_Features";
import Front_Index_Services_Count from "./Front_Index_Services_Count";
import Front_Index_Store from "./Front_Index_Store";
import Front_Index_Top_Servicemans from "./Front_Index_Top_Servicemans";
import Front_Index_Contact from "./Front_Index_Contact";

export default {
    name: "Front_Index_Main",
    components : {
        'index_topbanner' : Front_Index_Topbanner,
        'index_features' : Front_Index_Features,
        'index_services_count' : Front_Index_Services_Count,
        'index_store' : Front_Index_Store,
        'index_top_servicemans' : Front_Index_Top_Servicemans,
        'index_contact' : Front_Index_Contact,
    }
}
</script>

<style scoped>

</style>
