<template>
  <section>
      <h1>角色管理</h1>
       <el-table
      :data="tableData"
      style="width: 100%">
      <el-table-column
        prop="role_name"
        label="角色名称">
      </el-table-column>
       <el-table-column
        prop="role_dec"
        label="角色描述">
      </el-table-column>
        <el-table-column
        prop="create_time"
        label="创建时间">
      </el-table-column>
    </el-table>
  </section>
</template>

<script>
export default {
    data(){
        return {
            tableData:[]
        }
    },
    mounted(){
      this.loadData()
    },
    methods:{
        loadData(){
            // let param = new URLSearchParams()
            this.$axios.get('/apis/getRoleList').then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.tableData = res.data.list
                    }
                }

            })
        }
    }
}
</script>

<style>

</style>