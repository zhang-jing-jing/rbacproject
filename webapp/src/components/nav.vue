<template>
  <section>
    <el-menu :default-active="activeIndex" class="el-menu-demo" 
    background-color="#334272" text-color="#fff" active-text-color="#ffd04b"
    mode="horizontal" @select="handleSelect">
        <el-menu-item>------------logo---------</el-menu-item>
        <el-menu-item index="userManage" @click="menu('/user-manage')">用户管理</el-menu-item>
        <el-menu-item index="permissionManage" @click="menu('/permission-manage')">权限管理</el-menu-item>
        <el-menu-item index="roleManage" @click="menu('/role-manage')">角色管理</el-menu-item>
    </el-menu>
  </section>
</template>

<script>
export default {
    data(){
        return{
            activeIndex:'userManage'
        }
    },
    methods:{
        menu(path){
            this.$router.push({path:path})
        },
        handleSelect(){

        }
    }
}
</script>

<style>

</style>