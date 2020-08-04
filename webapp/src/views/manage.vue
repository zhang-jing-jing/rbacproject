<template>
  <el-container>
    <el-header>
        <topnav/>
    </el-header>
    <el-main>
        <router-view/>   
    </el-main>
  </el-container>
</template>

<script>
import topnav from "../components/nav"
export default {
    components:{
        topnav
    },
    methods:{

    }
}
</script>

<style>
.el-header{
    padding: 0!important;
}
</style>