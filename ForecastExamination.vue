<script setup>

import axios from "axios";
import {ref} from "vue";
import {ArrowLeft, ArrowRight} from "@element-plus/icons-vue";
import VChart from "vue-echarts";

const currentDate = new Date();
const year = currentDate.getFullYear() - 1 + '';
const month = currentDate.getMonth() < 10 ? '0' + (currentDate.getMonth() + 1 + '') : currentDate.getMonth() + 1 + ''


const text_of_option1 = ref('预测误差主要来自于对中纬度和冰岛附近低压的高估，能够预测出NAO的典型两级模态 ，模拟误差随着预测时长逐渐增加。')//表示前六个图底下的文字描述

const text_of_option7 = ref('对于为期1个月的NAOI预测，不如高分辨率模式ECMWF ，但与低分辨率模式ECCC相当。由于只接受月平均数作为输入，忽略了决定短时尺度可预测性的天气现象和初始条件。在超过两个月的提前期的预测技巧远远超过了失去预测能力的数值模式，将NAO的有效预测时间从1个月扩展到了6个月。')

const selectedYear = ref('');
const selectedMonth = ref('');

selectedYear.value = year;
selectedMonth.value = month;



const option7 = ref({})

const imgSrc_of_option1 = ref({})
const imgSrc_of_option2 = ref({})
const imgSrc_of_option3 = ref({})
const imgSrc_of_option4 = ref({})
const imgSrc_of_option5 = ref({})
const imgSrc_of_option6 = ref({})

const title_of_option1 = ref({})
const title_of_option2 = ref({})
const title_of_option3 = ref({})
const title_of_option4 = ref({})
const title_of_option5 = ref({})
const title_of_option6 = ref({})

//const list = ref({})

//axios.get('http://www.tjensoprediction.com:8080/nao/findGridData/nao?year='+Number(selectedYear.value)+'&month='+Number(selectedMonth.value))
axios.get('http://www.tjensoprediction.com:8080/nao/findGridData/nao?year=2021&month=6')
    .then(res => {
      console.log(res.data);
      list = res.data;
  });
axios.get('http://www.tjensoprediction.com:8080/nao/predictionExamination/naoi')
    .then(res => {
      console.log(res.data);
      // title_of_option1.value='提前1个月预测';
      // list = res.data.imgSrc;
      option7.value = res.data;
  });
</script>

<template>
  <div class="pageContent">
    <h1 class="title">
      NAO预测结果检验
    </h1>
    <div class="datePickerContainer">
      <el-date-picker @change="updateChartTitle" v-model="selectedYear" type="year" format="YYYY" value-format="YYYY" :clearable="false" style="width: 80px; height: 25px"/>
      <div class="text">年</div>
      <el-date-picker @change="updateChartTitle" v-model="selectedMonth" type="month" format="MM" value-format="MM" :clearable="false" style="width: 60px; height: 25px"/>
      <div class="text">月</div>
      <span class="demonstration">提示：选择范围：2015年—2021年</span>
    </div>    
    <el-tabs type="border-card">
      <el-tab-pane label="指数预测">
        <h2 class="title">
          {{ selectedYear }}年{{ selectedMonth }}月 预测结果分布误差图
        </h2>
        <div v-for="i in list">
          <img :src="i">
          <!-- <img class="picture" :src="i" alt="">           -->
        </div>
        <div class="description">
          {{ text_of_option1 }}
        </div>
      </el-tab-pane>
      <el-tab-pane label="模态预测">
        <h2 class="title">
           NAOI指数预测的相关系数
        </h2>
        <div class="chart">
          <v-chart :option="option7" autoresize></v-chart>
        </div>   
        <div class="description">
          {{ text_of_option7 }}
        </div>
      </el-tab-pane>
     
    </el-tabs>
  </div>
</template>

<style scoped lang="scss">
  .title {
    text-align: center
  }
  .chart {
    height: 500px;
  }

  .description {
    font-size: 16px;
  }

  .datePickerContainer {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 20px;
  }

  .text {
    margin-left: 5px;
    margin-right: 10px;
  }
</style>