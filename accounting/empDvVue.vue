<template>
  <p class="Location">
    <a href="#/dashboard/home" class="btn_set home">메인으로</a>
    <a href="#" class="btn_nav">회계</a>
    <span class="btn_nav bold"> 지출결의서 신청</span>
    <a href="#/dashboard/accounting/empDvVue" class="btn_set refresh"
      >새로고침</a
    >
  </p>

  <p class="conTitle">
    <span>지출결의서 신청</span>
  </p>

  <!-- 지출결의서 조회 조건 -->

  <div class="app_date_apply">
    <b>신청일자</b>
    <input
      type="date"
      id="from_date"
      name="from_date"
      v-model="fromDate"
      @change="slctDate"
    />
    ~
    <input
      type="date"
      id="to_date"
      name="to_date"
      v-model="toDate"
      @change="slctDate"
    /><span class="fr">
      <a href="" class="btnType blue" name="search" @click.prevent="search()">
        <span>조회</span></a
      ><br
    /></span>
    <a
      href=""
      class="btnType blue"
      name="modal"
      @click.prevent="detailModal('', 'I')"
      ><span>신규등록</span></a
    >
  </div>

  <div class="selectEmpDv">
    <b>계정대분류명</b>
    <selectComCombo
      comtype="acc"
      selectid="acc"
      type="all"
      selvalue=""
      v-model="accountCd"
    ></selectComCombo>
    <b>상세분류명</b>
    <selectComCombo
      comtype="accd"
      selectid="accs"
      type="cel"
      :searchkey="accountCd"
      selvalue=""
      v-model="detailAccountCd"
    ></selectComCombo>
    <b>승인여부</b>
    <select id="dv_sign" name="dv_sign" v-model="dvSign">
      <option value="">전체</option>
      <option value="1">승인</option>
      <option value="2">반려</option>
      <option value="3">승인대기중</option>
    </select>
  </div>

  <!-- 페이지에 출력할 컬럼명 -->
  <div class="divDvList">
    <table class="col">
      <caption>
        caption
      </caption>
      <colgroup>
        <col width="14%" />
        <col width="11%" />
        <col width="*%" />
        <col width="*%" />
        <col width="10%" />
        <col width="10%" />
        <col width="9%" />
        <col width="8%" />
        <col width="*" />
      </colgroup>

      <thead>
        <tr>
          <th scope="col">결의번호</th>
          <th scope="col">계정대분류명</th>
          <th scope="col">상세분류명</th>
          <th scope="col">거래처명</th>
          <th scope="col">신청일자</th>
          <th scope="col">사용일자</th>
          <th scope="col">지출금액</th>
          <th scope="col">승인여부</th>
          <th scope="col">승인자</th>
        </tr>
      </thead>
      <template v-if="dvListCnt == 0">
        <tbody>
          <td colspan="9">데이터가 존재하지 않습니다.</td>
        </tbody>
      </template>
      <tbody v-for="(list, item) in dvList" :key="item" id="listEmpDv">
        <tr @click.prevent="detailModal(list.dv_code, 'U')">
          <td>B-{{ list.dv_code }}-{{ list.dv_date }}</td>
          <td>{{ list.bacc_name }}</td>
          <td>{{ list.dacc_name }}</td>
          <td>{{ list.biz_name }}</td>
          <td>{{ list.dv_date }}</td>
          <td>{{ list.dv_udate }}</td>
          <td>{{ $comma(list.dv_fee) }}</td>
          <template v-if="list.dv_sign == 1">
            <td>승인</td>
          </template>
          <template v-if="list.dv_sign == 2">
            <td>반려</td>
          </template>
          <template v-if="list.dv_sign == 3">
            <td>승인대기</td>
          </template>
          <td>{{ list.signName }}</td>
        </tr>
      </tbody>
    </table>
  </div>
  <div
    class="paging_area"
    id="empDvPagination"
    style="position: relative; bottom: 25.1px"
  >
    <paginate
      class="justify-content-center"
      v-model="cpage"
      :page-count="totalPage"
      :page-range="5"
      :margin-pages="0"
      :click-handler="empDvList"
      :prev-text="'Prev'"
      :next-text="'Next'"
      :container-class="'pagination'"
      :page-class="'page-item'"
      v-if="dvListCnt > 0"
    >
    </paginate>
  </div>
  <!-- {{ this.$session.get('loginId') }} -->
</template>
<script>
import { vueListAxios } from '../accounting';
import paginate from 'vuejs-paginate-next';
import selectComCombo from '@/components/common/selectComCombo.vue';
import { openModal } from 'jenesius-vue-modal';
import empDvVueModal from './empDvVueModal.vue';
export default {
  components: {
    selectComCombo,
    paginate,
  },
  data() {
    return {
      dvList: [],
      dvListCnt: '',
      scrtitle: '',
      fromDate: '',
      toDate: '',
      accountCd: '',
      detailAccountCd: '',
      dvSign: '',
      pageSize: 5,
      cpage: 1,
      totalPage: 1,

      loginID: this.$session.get('loginId'),
      userNm: this.$session.get('userNm'),
    };
  },
  mounted() {
    this.empDvList();
  },
  methods: {
    empDvList: function (cpage) {
      this.cpage = cpage || 1;
      let params = new URLSearchParams();
      params.append('from_date', this.fromDate);
      params.append('to_date', this.toDate);
      params.append('account_cd', this.accountCd);
      params.append('detail_account_cd', this.detailAccountCd);
      params.append('dv_sign', this.dvSign);
      params.append('cpage', this.cpage);
      params.append('loginID', this.loginID);
      params.append('userNm', this.userNm);
      params.append('pageSize', this.pageSize);

      vueListAxios('/accounting/DvlistVue.do', params)
        .then((result) => {
          this.dvList = result.data.dvList;
          this.dvListCnt = result.data.dvListcnt;
          this.totalPage = this.page();
        })
        .catch((err) => {
          alert(err);
        });
    },
    page: function () {
      let total = this.dvListCnt;
      let page = this.pageSize;
      let xx = total % page;
      let result = parseInt(total / page);
      if (xx == 0) {
        return result;
      } else {
        result = result + 1;
        return result;
      }
    },
    search: function () {
      this.slctDate();
      this.empDvList();
    },
    detailModal: async function (dv_code, action) {
      console.log('dv_code : ' + JSON.stringify(dv_code));
      console.log('action : ' + JSON.stringify(action));

      const modal = await openModal(empDvVueModal, {
        modalDvCode: dv_code,
        dvAction: action,
      });
      modal.onclose = () => {
        this.empDvList();
      };
    },
    slctDate() {
      this.$checkStartEndDate(this.fromDate, this.toDate);
      return true;
    },
  },
};
</script>
