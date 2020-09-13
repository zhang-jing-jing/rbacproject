<template>
  <section>
    <el-menu :default-active="activeIndex" class="el-menu-demo" 
    background-color="#334272" text-color="#fff" active-text-color="#ffd04b" @select="handleSelect"
    mode="horizontal">
        <el-menu-item style="margin-right:60px">RBAC管理系统</el-menu-item>
        <el-menu-item v-if="permission.indexOf('用户') > -1" index="userManage" @click="menu('/user-manage')">用户管理</el-menu-item>
        <el-menu-item v-if="permission.indexOf('权限') > -1" index="permissionManage" @click="menu('/permission-manage')">权限管理</el-menu-item>
        <el-menu-item v-if="permission.indexOf('角色') > -1" index="roleManage" @click="menu('/role-manage')">角色管理</el-menu-item>
        <!-- <el-menu-item index="roleManage" @click="menu('/role-manage')">角色管理</el-menu-item> -->
        <el-menu-item index="roleManage" style="float:right" @click="logout"><i class="el-icon-switch-button" style="color:#ffffff"></i>退出</el-menu-item>
        <el-menu-item index="personalCenter" style="float:right">欢迎您：{{user.user_name}}</el-menu-item>
    </el-menu>
  </section>
</template>

<script>
export default {
    data(){
        return{
            activeIndex:'userManage',
            permission:''
        }
    },
    create(){
        this.$store.state = localStorage.getItem('state')
    },
    computed:{
        user(){
            return this.$store.state.user
        }
    },
    mounted(){
        this.activeIndex = this.$store.state.activeIndex;
        this.permission = this.$store.state.user.permission.join(',')
    },
    methods:{
        menu(path){
            this.$router.push({path:path})
        },
        logout(){
            this.$axios.post('/apis/logout').then(res=>{
                if(res.status == 200 && res.data.status == 0){
                    this.$store.commit('setActiveIndex',"userManage")
                    this.$router.push({path:'/'})
                }
            })
        },
        handleSelect(index){
            this.$store.commit('setActiveIndex',index)
        }
    }
}
</script>

<style>

</style>