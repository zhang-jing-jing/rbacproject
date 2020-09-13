<template>
  <section>
      <h1>权限管理</h1>
      <el-row>
        <el-col :span="12">
          <el-tree v-if="permission.indexOf('20') > -1" :props="props"
              :data="tableData" highlight-current default-expand-all>
              <span class="custom-tree-node" slot-scope="{ node, data }">
              <span class="tree-label">{{ node.label }}</span>
              <span>
                <el-button v-if="permission.indexOf('19') > -1" icon="el-icon-plus"
                  type="text"
                  size="mini"
                  @click.stop="() => append(node,data)">
                </el-button>
                 <el-button v-if="permission.indexOf('23') > -1" icon="el-icon-edit"
                  type="text"
                  size="mini"
                  @click.stop="() => updateNode(node,data)">
                </el-button>
                <el-popconfirm
                    confirmButtonText='确定'
                    cancelButtonText='取消'
                    icon="el-icon-info"
                    title="你确定删除该节点？"
                    @onConfirm="remove(node, data)"
                  >
                  <el-button v-if="permission.indexOf('22') > -1" icon="el-icon-delete" slot="reference"
                      type="text"
                      size="mini">
                    </el-button>
                  </el-popconfirm>
              </span>
              </span>
            </el-tree>
        </el-col>
      </el-row>
      <el-dialog :title="currentNode.permission_name+'-添加子节点'"
        :visible.sync="dialogVisible" width="600px">
        <el-form :model="perForm" label-width="80px" style="width:80%;margin:0 auto;">
            <el-form-item label="权限名称">
              <el-input v-model="perForm.name"></el-input>
            </el-form-item>
            <el-form-item label="权限描述">
              <el-input v-model="perForm.dec"></el-input>
            </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="confirmAdd">确 定</el-button>
        </span>
      </el-dialog>

      <el-dialog :title="currentNode.permission_name+'-编辑子节点'"
        :visible.sync="dialogUpdateVisible" width="600px">
        <el-form :model="updateForm" label-width="80px" style="width:80%;margin:0 auto;">
            <el-form-item label="权限名称">
              <el-input v-model="updateForm.permission_name"></el-input>
            </el-form-item>
            <el-form-item label="权限描述">
              <el-input v-model="updateForm.permission_dec"></el-input>
            </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogUpdateVisible = false">取 消</el-button>
          <el-button type="primary" @click="confirmUpdate">确 定</el-button>
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
            currentNode:{},
            dialogVisible:false,
            dialogUpdateVisible:false,
            perForm:{},
            updateForm:{},
            permission:''
        }
    },
    mounted(){
      this.loadData()
      this.permission = this.$store.state.user.permission.join(',')
    },
    methods:{
        loadData(){
          this.$axios.get('/apis/getPermissionList').then(res=>{
              if (res.status === 200) {
                  if(res.data.status === 0){
                      this.tableData = res.data.list
                  }else if(res.data.status === 600){
                      this.$router.push({path:'/'})
                  }
              }
          })
        },
        append(node, data){
          this.currentNode = data;
          this.dialogVisible = true;
        },
        updateNode(node, data){
          this.currentNode = data;
          this.updateForm = JSON.parse(JSON.stringify(this.currentNode))
          console.log('++++++',this.currentNode)
          this.dialogUpdateVisible = true;
        },
        confirmAdd(){
            let self = this;
            let param = new URLSearchParams()
            param.append('permission_id',-1)
            param.append('pid',this.currentNode.permission_id)
            param.append('permission_name',this.perForm.name)
            param.append('permission_dec',this.perForm.dec)
            this.$axios.post('/apis/addPermission',param).then(res=>{
              if(res.status === 200){
                if( res.data.status === 0){
                  self.$message({
                      message: res.data.message,
                      type: 'success'
                  });
                  self.dialogVisible = false
                  self.currentNode.children.push(res.data.list)
                }else if(res.data.status === 600){
                    this.$router.push({path:'/'})
                }else{
                  self.$message({
                      message: res.data.message,
                      type: 'warning'
                  });
                }
              }
            })
        },
        confirmUpdate(){
            let self = this;
            let param = new URLSearchParams()
            param.append('permission_id',this.updateForm.permission_id)
            param.append('pid',this.updateForm.pid)
            param.append('permission_name',this.updateForm.permission_name)
            param.append('permission_dec',this.updateForm.permission_dec)
            this.$axios.post('/apis/addPermission',param).then(res=>{
              if(res.status === 200){
                if( res.data.status === 0){
                  self.$message({
                      message: res.data.message,
                      type: 'success'
                  });
                  self.currentNode.permission_name = self.updateForm.permission_name;
                  self.currentNode.permission_dec = self.updateForm.permission_dec;
                  self.dialogUpdateVisible = false
                }else if(res.data.status === 600){
                    this.$router.push({path:'/'})
                }else{
                  self.$message({
                      message: res.data.message,
                      type: 'warning'
                  });
                }
              }
            })
        },
        remove(node,data){
          console.log(data.permission_id)
          let param = new URLSearchParams()
          param.append('permission_id',data.permission_id)
          this.$axios.delete('/apis/deletePermission',{data: param}).then(res=>{
            console.log(res)
            if(res.status === 200 && res.data.status === 0){
                 this.$message({
                      message: res.data.message,
                      type: 'success'
                  });
                  this.loadData()
            }else if(res.status === 200 && res.data.status === 600){
                this.$router.push({path:'/'})
            }
          })
        }
    }
}
</script>

<style lang="scss">
  .custom-tree-node {
    flex: 1;
    display: flex;
    align-items: center;
    font-size: 14px;
    padding-right: 8px;
    .tree-label{
      margin-right: 15px;
    }
    .el-button{
      color: #333333;
    }
  }
</style>