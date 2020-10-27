<template>
  <section>
      <h1>角色管理</h1>
      <el-row>
          <el-col :span="18">
            <el-button size="small" type="primary" v-if="permission.indexOf('16') > -1" @click="addRole">添加角色</el-button> 
            <el-button size="small" type="primary" v-if="permission.indexOf('17') > -1" @click="deleteRole">删除角色</el-button> 
          </el-col>
            <el-col :span="6">
              <el-input size="small" placeholder="请输入内容" v-model.trim="queryContent" class="input-with-select">
                <el-select v-model="querySelect" style="width:100px" slot="prepend" placeholder="请选择">
                  <template v-for="item in queryOption">
                    <el-option :key="item.value" :label="item.label" :value="item.value"></el-option>
                  </template>  
                </el-select>
                <el-button slot="append" icon="el-icon-search" @click="handleFilterRole"></el-button>
              </el-input>
        </el-col>
      </el-row>
       <el-table v-if="permission.indexOf('14') > -1" :data="tableData" style="width: 100%" @selection-change="handleSelectionChange">
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
        label="操作">
        <template slot-scope="scope">
            <el-button v-if="permission.indexOf('15') > -1" @click="handleUpdateRole(scope.row)">修改</el-button>
        </template>    
      </el-table-column>
    </el-table>
     <el-pagination style="text-align: right;"
          :current-page="currentPage"
          :page-size="pageSize"
          layout="prev, pager, next"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange">
        </el-pagination>
    <el-dialog title="修改权限"
        :visible.sync="dialogVisible"
        width="30%">
        <el-tree ref="tree" node-key="permission_id" :props="props" show-checkbox :data="permissionData" highlight-current default-expand-all>
        </el-tree>
        <span slot="footer" class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="updateRole">确 定</el-button>
        </span>
    </el-dialog>
    <el-dialog :title="dialogTitle" :visible.sync="addDialogVisible" width="700px">
         <el-form style="width:80%;margin:0 auto;" ref="roleForm" :rules="rules" :model="roleForm" label-width="80px">
          <el-form-item label="角色名称" prop="role_name">
            <el-input v-model="roleForm.role_name"></el-input>
          </el-form-item>
          <el-form-item label="角色描述" prop="role_dec">
            <el-input v-model="roleForm.role_dec"></el-input>
          </el-form-item>
          <el-form-item label="权限" prop="permission">
            <el-tree ref="dialogTree" node-key="permission_id" :props="props" show-checkbox :data="permissionData" highlight-current 
            default-expand-all @check="handleCheckChange">
            </el-tree>
          </el-form-item>
        </el-form>
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
            selectRole:[],
            roleForm:{
              role_name:'',
              role_dec:''
            },
            rules: {
                role_name: [
                    { required: true, message: '请输入角色名称', trigger: 'blur' },
                    { min: 1, max: 10, message: '长度在1到10个字符', trigger: 'blur' }
                ],
                role_dec: [
                    { required: false, message: '请输入角色描述', trigger: 'change' }
                ]
            },
            dialogTitle:'添加角色',
            permission:'',
            total:0,
            pageSize:10,
            currentPage:1,
            queryContent:'',
            querySelect:'',
            queryOption:[
              {label:'角色名称',value:'role_name'},
              {label:'角色描述',value:'role_dec'},
              {label:'权限',value:'permission'}
            ]
        }
    },
    mounted(){
      this.loadData();
      this.loadPermission()
      this.permission = this.$store.state.user.permission.join(',')
    },
    methods:{
        handleFilterRole(){
            if (this.querySelect == "") {
                this.$message({
                    type: 'warning',
                    message: '请选择查询字段!'
                });
            }else{
                this.loadData()
            }
        },
        handleSizeChange(val) {
          this.pageSize = val
        },
        handleCurrentChange(val) {
          this.currentPage = val
          this.loadData()
        },
        loadData(){
            let param = new URLSearchParams()
            param.append('index',this.currentPage)
            param.append('pagesize', this.pageSize)
            param.append('queryValue',this.querySelect)
            param.append('queryText',this.queryContent)
            this.$axios.post('/apis/getRoleList',param).then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.tableData = res.data.list
                        this.total = res.data.total
                        console.log('this.tableData',this.tableData)
                    }else if(res.data.status === 600){
                        this.$router.push({path:'/'})
                    }
                }

            })
        },
        loadPermission(){
          this.$axios.get('/apis/getPermissionList').then(res=>{
                if (res.status === 200) {
                    if(res.data.status === 0){
                        this.permissionData = res.data.list
                    }else if(res.data.status === 600){
                        this.$router.push({path:'/'})
                    }
                }
            })
        },
        handleUpdateRole(row){
            this.dialogTitle = "修改角色"
            this.addDialogVisible = true;
            this.roleForm = row;
            let temp = []
            if(this.roleForm.permission.length > 0){
                this.roleForm.permission.forEach(element => {
                    temp.push(element[0])
                });
            }
            this.$nextTick(function(){
                this.$refs.dialogTree.setCheckedKeys(temp)
            })
        },
        updateRole(){
            let per_ids = this.$refs.dialogTree.getCheckedKeys().join(',')
            let param = new URLSearchParams()
            param.append('role_id',this.roleForm.role_id)
            param.append('role_dec',this.roleForm.role_dec)
            param.append('role_name',this.roleForm.role_name)
            param.append('permission',per_ids)
            this.$axios.post('/apis/role/updateRole',param).then(res=>{
                if(res.status === 200 && res.data.status === 0){
                    this.$message({
                      message: res.data.message,
                      type: 'success'
                  });
                }else if(res.status === 200 && res.data.status === 600){
                    this.$router.push({path:'/'})
                }
                this.addDialogVisible = false;
                this.loadData();
            })
        },
        handleSelectionChange(val){
            this.selectRole = val;
        },
        addRole(){
            this.addDialogVisible = true;
            this.dialogTitle = "添加角色";
            this.roleForm = {}
        },
        deleteRole(){ 
            if(this.selectRole.length == 0){
                this.$message({
                    type: 'warning',
                    message: '请选择要删除的角色!'
                });
                return
            }
              this.$confirm('删除所选角色？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消'
            }).then(() => {
                let tempId = [];
                this.selectRole.forEach(item=>{
                    tempId.push(item.role_id)
                })
                let param = new URLSearchParams()
                param.append('ids',tempId.join(','))
                this.$axios.delete('/apis/role/deleteRole',{data: param}).then(res=>{
                    if(res.status === 200){
                        if(res.data.status === 0){
                            this.$message({
                                type:"success",
                                message:res.data.message
                            })
                            this.loadData()
                        }else{
                            this.$message({
                                type:"error",
                                message:res.data.message
                            })
                        }
                    }
                })
            }).catch(() => {
            });
        },
        confirmAddRole(){
          this.$refs['roleForm'].validate((valid) => {
              if(valid){
                let param = new URLSearchParams()
                param.append('role_name',this.roleForm.role_name);
                param.append('role_dec',this.roleForm.role_dec);
                param.append('permission',this.roleForm.permission);
                if(this.roleForm.role_id){
                  this.updateRole()
                } else{
                   this.$axios.post('/apis/role/addRole',param).then(res=>{
                        if(res.status === 200){
                            if( res.data.status === 0){
                              this.$message({
                                  type: 'success',
                                  message: '添加成功!'
                              })
                              this.loadData()
                            }else if( res.data.status === 600){
                                this.$router.push({path:'/'})
                            }
                            this.addDialogVisible = false;
                        }
                      })
                } 
              }
          })
        },
        handleCheckChange(){
          this.roleForm.permission = this.$refs.dialogTree.getCheckedKeys().join(',')
        }
    }
}
</script>

<style>

</style>