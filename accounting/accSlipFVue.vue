<!-- eslint-disable vue/no-parsing-error -->
<!-- eslint-disable prettier/prettier -->
<template>
  <div id="container">
    <ul>
      <li class="contents">
        <!-- contents -->
        <h3 class="hidden">contents 영역</h3>
        <!-- content -->
        <div class="content">
          <p class="Location">
            <a href="../dashboard/dashboard.do" class="btn_set home"
              >메인으로</a
            >
            <span class="btn_nav bold">회계</span>
            <span class="btn_nav bold">회계전표 조회</span>
            <a href="../system/comnCodMgr.do" class="btn_set refresh"
              >새로고침</a
            >
          </p>
          <p class="conTitle" style="height: auto">
            <span>회계전표 조회</span>
            <span class="fr">
              <span>계정과목</span>
              <selectComCombo
                comtype="acc"
                selectid="acc"
                type="all"
                selvalue=""
                v-model="accd"
              ></selectComCombo>
              <a
                class="btnType blue"
                id="searchBtn"
                href=""
                @click.prevent="getSearch(accd)"
              >
                <span> 조회 </span>
              </a>
              <a
                href=""
                class="btnType blue"
                id="searchDetailBtn"
                @click.prevent="getSearchDetail()"
              >
                <span> 상세조회 </span>
              </a>
            </span>
          </p>
          <div class="divComGrpCodList">
            <table class="col">
              <caption>
                caption
              </caption>
              <colgroup>
                <col width="3%" />
                <col width="6%" />
                <col width="9%" />
                <col width="9%" />
                <col width="8%" />
              </colgroup>
              <thead>
                <tr>
                  <th scope="col">번호</th>
                  <th scope="col">계정코드</th>
                  <th scope="col">계정과목</th>
                  <th scope="col">지출</th>
                  <th scope="col">수입</th>
                </tr>
              </thead>

              <!-- MAIN -->
              <tbody scope="col" id="listNotice">
                <tr v-for="(item, index) in listNotice" :key="index">
                  <td>{{ pageSize * (cpage - 1) + 1 + index }}</td>
                  <td>{{ item.bacc_code }}</td>
                  <td>{{ item.bacc_name }}</td>
                  <td>{{ $comma(item.dv_ep) }}</td>
                  <td>{{ $comma(item.dv_fee) }}</td>
                </tr>
              </tbody>
            </table>
          </div>
          <div></div>
          <div
            class="paging_area"
            id="noticePagination"
            style="position: relative; bottom: 25.1px"
          >
            <paginate
              class="justify-content-center"
              v-model="cpage"
              :page-count="totalPage"
              :page-range="5"
              :margin-pages="0"
              :click-handler="clickCallback"
              :prev-text="'Prev'"
              :next-text="'Next'"
              :container-class="'pagination'"
              :page-class="'page-item'"
            >
            </paginate>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>
<!-- ========================================================================================= -->
<script>
import selectComCombo from '@/components/common/selectComCombo.vue';
import axios from 'axios';
import Paginate from 'vuejs-paginate-next';
//-- MODAL ------------------------------------------------------------
import { openModal } from 'jenesius-vue-modal';
import accSlipFVueModal from './accSlipFVueModal.vue';
//---------------------------------------------------------
export default {
  data: function () {
    return {
      pageSize: 10,
      pageBlockSize: 5,
      cpage: 0,
      bacc_name: '',
      bacc_code: '',
      dv_ep: '',
      dv_fee: '',
      listNotice: [],
      result: 0,
      noticePagination: '',
      totalPage: 1,
      totalCnt: 0,
      accd: '',
    };
  },
  mounted() {
    this.searchaccslipf(1);
  },
  components: {
    Paginate: Paginate,
    selectComCombo,
  },
  methods: {
    searchaccslipf: function (cpage) {
      let vm = this;
      vm.cpage = cpage || 1;
      let params = new URLSearchParams();
      params.append('pageSize', vm.pageSize);
      params.append('cpage', vm.cpage);
      params.append('baccname', vm.accd);
      axios
        .post('/accounting/accslipflistVue.do', params)
        .then((res) => {
          vm.armngList = res.data.listARM;
          vm.counthnoticelist = res.data.counthnoticelist;
          vm.listNotice = res.data.accslipflist;
          vm.totalCnt = res.data.countaccslipflist;
          vm.totalPage = vm.page();
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    },
    getSearch: function (accd) {
      this.accd = accd;
      this.searchaccslipf(1);
    },
    page: function () {
      var total = this.totalCnt;
      var page = this.pageSize;
      var xx = total % page;
      var result = parseInt(total / page);
      if (xx == 0) {
        return result;
      } else {
        result = result + 1;
        return result;
      }
    },
    clickCallback: function (pageNum) {
      this.cpage = pageNum;
      this.searchaccslipf(this.cpage);
    },
    // --- MODAL -----------------------------------------------------------------
    // 상세조회
    getSearchDetail: async function () {
      const modal = await openModal(accSlipFVueModal, {
        popUpItems: this.listNotice,
      });
      modal.onclose = () => {
        console.log('the modal popup is closed...');
      };
    },
  },
};
</script>
