<template>
  <section>
      <h1>角色管理</h1>
      <div>
            <el-button @click="addRole">添加角色</el-button> 
            <el-button  @click="deleteRole">删除角色</el-button> 
      </div>
       <el-table :data="tableData" style="width: 100%" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
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
       <el-table-column
        prop="permission"
        label="权限">
         <template slot-scope="scope">
             <span v-for="(item,index) in scope.row.permission" :key="index">
                {{item[1]}},
             </span>
        </template> 
      </el-table-column>
      <el-table-column
        label="修改权限">
        <template slot-scope="scope">
            <el-button @click="handleUpdatePermission(scope.row)">修改权限</el-button>
        </template>    
      </el-table-column>
    </el-table>
    <el-dialog title="修改权限"
        :visible.sync="dialogVisible"
        width="30%">
          <el-tree ref="tree" node-key="permission_id" :props="props" show-checkbox :data="permissionData" highlight-current default-expand-all>
        </el-tree>
        <span slot="footer" class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="updatePermission">确 定</el-button>
        </span>
    </el-dialog>
    <el-dialog title="添加角色" :visible.sync="addDialogVisible" width="700px">
        <span slot="footer" class="dialog-footer">
            <el-button @click="addDialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="confirmAddRole">确 定</el-button>
        </span>
    </el-dialog>
  </section>
</template>

<script>
export default {
    data(){
        return {
            props: {
              label: 'permission_name',
              isLeaf: function(data) {
                return !(data.leafCount)
             },
             children:'children'
            },
            tableData:[],
            permissionData:[],
            currentRole:{},
            dialogVisible:false,
            addDialogVisible:false,
            selectRole:[]
        }
    },
    mounted(){
      this.loadData();
      this.loadPermission()
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
        },
        loadPermission(){
          this.$axios.get('/apis/getPermissionList').then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.permissionData = res.data.list
                    }
                }
            })
        },
        handleUpdatePermission(row){
            console.log(row)
            this.dialogVisible = true;
            this.currentRole = row;
            let temp = []
            if(this.currentRole.permission.length > 0){
                this.currentRole.permission.forEach(element => {
                    temp.push(element[0])
                });
            }
            this.$nextTick(function(){
                this.$refs.tree.setCheckedKeys(temp)
            })
        },
        updatePermission(){
            // console.log(this.$refs.tree.getCheckedKeys())
            let per_ids = this.$refs.tree.getCheckedKeys().join(',')
            let param = new URLSearchParams()
            param.append('role_id',this.currentRole.role_id)
            param.append('permission_ids',per_ids)
            if(per_ids.length === 0){
                return
            }
            this.$axios.post('/apis/role/addRolePermission',param).then(res=>{
                if(res.status === 200 && res.data.status === 0){
                    this.$message({
                      message: res.data.message,
                      type: 'success'
                  });
                }
                this.dialogVisible = false;
                this.loadData();
            })
        },
        handleSelectionChange(val){
            this.selectRole = val;
            console.log('selectRole++++++',this.selectRole)
        },
        addRole(){
            this.addDialogVisible = true;
        },
        deleteRole(){
              this.$confirm('删除所选角色？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消'
            }).then(() => {
                this.$message({
                    type: 'success',
                    message: '删除成功!'
                });
            }).catch(() => {
            });
        },
        confirmAddRole(){

        }
    }
}
</script>

<style>

</style>