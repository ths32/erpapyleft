<template>
  <div
    id="layer2"
    class="layerType2"
    style="width: 900px; top: 111.5px; left: 220px"
  >
    <dl>
      <dt>
        <strong>회계전표</strong>
      </dt>
      <dd style="height: auto">
        <h1 style="font-size: 50px; height: 85px; padding-top: 2%; width: 30%">
          회계전표
        </h1>
        <div style="width: 100%; height: 250px; overflow: auto">
          <table class="scrolltbody col">
            <colgroup>
              <col width="91.11px" />
              <col width="91.11px" />
              <col width="91.11px" />
              <col width="91.11px" />
            </colgroup>
            <thead>
              <tr>
                <th scope="col">전표번호</th>
                <th scope="col">계정과목</th>
                <th scope="col">지출</th>
                <th scope="col">수입</th>
              </tr>
            </thead>

            <tbody scope="col" id="listResult" class="accSlipListModal">
              <tr v-for="(list, index) in listResult" :key="index">
                <!-- 전표번호 -->
                <td>{{ list.fnl_code }}</td>
                <!-- 계정과목  -->
                <td>{{ list.bacc_name }}</td>
                <!-- 수입  -->
                <td>{{ $comma(list.dv_ep) }}</td>
                <!-- 지출  -->
                <td>{{ $comma(list.dv_fee) }}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <table class="col">
          <colgroup>
            <col width="525px" />
            <col width="247px" />
            <col width="247px" />
            <col width="1px" />
            <col width="117.47px" />
          </colgroup>
          <tr>
            <td
              style="
                font-weight: bold;
                color: #333;
                background-color: rgb(220, 225, 230);
                text-align: center;
                overflow: auto;
                font-weight: bold;
                width: 49%;
                height: 40px;
              "
            >
              합&nbsp;&nbsp;&nbsp;&nbsp;계
            </td>
            <td style="text-align: center; border='10'">
              <div id="inamtarea">{{ $comma(sdv_ep) }}</div>
            </td>
            <td style="text-align: center">
              <div id="outamtarea">
                {{ $comma(sdv_fee) }}
              </div>
            </td>
            <!-- <td style="font-color: rgb(220, 225, 230)"></td> -->
          </tr>
        </table>

        <div class="btn_areaC mt20" id="btnClose" name="btn">
          <a href="" @click.prevent="closeThis" class="btnType gray"
            ><span>닫기</span></a
          >
        </div>
      </dd>
    </dl>
  </div>
</template>
<style>
#modalEx {
  width: 100%;
  height: 100%;
  background-color: rgba(12, 1, 1, 0.2);
}
.black-bg {
  width: 100%;
  height: 100%;

  position: fixed;
  padding: 20px;
}
.white-bg {
  width: 50%;
  background: ivory;
  border-radius: 8px;
  padding: 8px;
  margin-left: 20%;
  margin-top: 5%;
}
.fileCss {
  margin-left: 5%;
}
</style>
<script>
import axios from 'axios';
import { closeModal } from 'jenesius-vue-modal';
export default {
  props: { popupItems: Object, paction: String },
  data: function () {
    return {
      popUpItems: {},
      popUpObj: {},
      listResult: [],
      bacc_code: '',
      bacc_name: '',
      dv_ep: '',
      dv_fee: '',
      sdv_ep: 0,
      sdv_fee: 0,
    };
  },
  mounted() {
    this.popUpObj = this.popUpItems;
    this.bacc_code = this.popUpObj.bacc_code;
    this.bacc_name = this.popUpObj.bacc_name;
    this.dv_ep = this.popUpObj.dv_ep;
    this.dv_fee = this.popUpObj.dv_fee;

    this.getPopUpItems();
  },
  methods: {
    getPopUpItems: function () {
      let vm = this;
      let params = new URLSearchParams();
      params.append('bacc_code', vm.bacc_code);
      params.append('bacc_name', vm.bacc_name);
      params.append('dv_ep', vm.dv_ep);
      params.append('dv_fee', vm.dv_fee);
      axios
        .post('/accounting/accslipfmodalVue.do', params)
        .then((res) => {
          vm.listResult = res.data.accslipfmodal;
          // 합계
          vm.listResult.forEach((result) => {
            this.sdv_ep += result.dv_ep;
            this.sdv_fee += result.dv_fee;
          });
          this.listresult = vm.listResult;
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    },
    closeThis: function () {
      closeModal(this);
      this.emitter.emit('close', null);
    },
  },
};
</script>
