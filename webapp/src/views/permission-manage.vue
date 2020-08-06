<template>
  <section>
      <h1>用户管理</h1>
       <el-table
      :data="tableData"
      style="width: 100%">
      <el-table-column
        prop="account"
        label="账号">
      </el-table-column>
      <el-table-column
        prop="user_name"
        label="用户姓名">
      </el-table-column>
      <el-table-column
        prop="phone"
        label="手机">
      </el-table-column>
      <el-table-column
        prop="email"
        label="邮箱">
      </el-table-column>
       <el-table-column
        prop="login_count"
        label="登录次数">
      </el-table-column>
        <el-table-column
        prop="create_time"
        label="创建时间">
      </el-table-column>
        <el-table-column
        prop="last_login_time"
        label="上次登录时间">
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
            this.$axios.get('/apis/getUserList').then(res=>{
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