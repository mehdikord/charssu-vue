<template>
    <div>
        <div :class="classes" v-for="(error,index) in this.ValidationErrors(errors,field)" class="text-danger mt-1 font-size-13">
            {{error}}
        </div>
    </div>
</template>

<script>
export default {
    name: "Manage_Inc_Validation_Error",
    props:['errors','field','classes']
}
</script>

<style scoped>

</style>

