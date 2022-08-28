<template>
    <div class="text-center">
        <img src="/images/default/loading1.gif" :width="width" alt="">
        <div class="text-center mt-2">
            {{ text }}
        </div>
    </div>

</template>

<script>
export default {
    name: "Front_Inc_Loading1",
    props :['width','text']
}
</script>

<style scoped>

</style>
