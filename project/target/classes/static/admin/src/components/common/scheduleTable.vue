<template>
  <div>
    <el-table :data="tableData" :empty-text="'没有数据'" size="mini">
      <el-table-column prop="name" label="名称" width="180">
        <template slot-scope="scope">
          <el-input v-model="scope.row.name" placeholder="请输入名称"></el-input>
        </template>
      </el-table-column>
      <el-table-column prop="startTime" label="开始时间" width="260">
        <template slot-scope="scope">
          <el-time-select placeholder="起始时间" v-model="scope.row.startTime" :picker-options="{
            start: '07:00',
            step: '00:10',
            end: '23:50'
          }">
          </el-time-select>
        </template>
      </el-table-column>
      <el-table-column prop="endTime" label="结束时间" width="260">
        <template slot-scope="scope">
          <el-time-select placeholder="结束时间" v-model="scope.row.endTime" :picker-options="{
            start: '07:10',
            step: '00:10',
            end: '23:50',
            minTime: scope.row.startTime
          }">
          </el-time-select>
        </template>
      </el-table-column>
      <el-table-column prop="count" label="数目">
        <template slot-scope="scope">
          <el-input-number v-model="scope.row.count" :min="1" :max="max">
          </el-input-number>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="100">
        <template slot-scope="scope">
          <el-button @click="deleteRow(scope.$index)" type="text" size="small">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-button type="text" @click="addRow">+新增一行</el-button>
  </div>
</template>

<script>
export default {
  props: {
    jsonStr: {
      type: String,
      default: "[]",
    },
    max: {
      type: Number,
      default: 1,
    },
  },
  data() {
    return {
      tableData: [{
        name: '',
        startTime: '',
        endTime: '',
        count: ''
      }],
    };
  },
  watch: {
    jsonStr: {
      immediate: true,
      handler(newVal) {
        try {
          this.tableData = JSON.parse(newVal);
        } catch (e) {
          this.tableData = [];
        }
      },
    },
  },
  methods: {
    addRow() {
      const newRow = {
        name: '',
        startTime: '',
        endTime: '',
        count: '',
      };
      this.tableData.push(newRow);
    },
    deleteRow(index) {
      this.tableData.splice(index, 1);
    },
  }
};
</script>