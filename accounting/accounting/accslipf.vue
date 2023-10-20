<template>
  <div id="comnCodMgr">
    <p class="Location">
      <a href="/dashboard/dashboard.do" class="btn_set home"></a>
      <span class="btn_nav bold">회계</span>
      <span class="btn_nav bold">회계전표 조회</span>
      <a href="../accounting/accSlipFVue.do" class="btn_set refresh"
        >새로고침</a
      >
    </p>

    <p class="conTitle" style="height: auto">
      <span>회계전표 조회</span>
      <span>
        <!-- <table
          style="collapse; border: 1px #50bcdf;"
          width="100%"
          cellpadding="5"
          cellspacing="0"
          border="1"
          align="left"
        > -->
         <!-- <tr style="border: 0px; border-color: blue"> -->
            <!-- <td
              width="50"
              height="25"
              style="font-size: 100%; text-align: left"
            > -->
              <div id="searchArea" class="d-flex justify-content-around">
                <span>계정과목</span>
                <select
                  id="baccname"
                  class="form-control"
                  style="width: 80px"
                  v-model="searchKey"
                >
                  <option value="전체">전체</option>
                  <option value="급여">급여</option>
                  <option value="영업">영업</option>
                </select>

                <input
                  type="text"
                  style="width: 55%"
                  class="form-control"
                  v-model="sname"
                />
                <span class="fr">
                  <a
                    class="btn btn-light mx-2"
                    @click="rowClicked()"
                    name="btn"
                  >
                    <span>조회</span>
                  </a>
                  <a
                    @click.prevent="listarea2.fn_fPopModalAccSlip()"
                    class="btn btn-primary mx-2"
                    id="submitBtn"
                    style="margin-bottom: 10px;"
                    name="modal"
                  >
                    <span>상세조회</span>
                  </a>
                </span>
              </div>
              <!-- 상세조회 버튼 : class="btnType blue" -->
              <!-- listarea2 not declared yet -->
            <!-- </td> -->
          <!--</tr> -->
        </table>
      </span>
    </p>

    <div class="divComGrpCodList">
      <table class="col">
        <caption>
          caption
        </caption>
        <colgroup>
          <col width="3%">
					<col width="6%">
					<col width="9%">
					<col width="9%">
					<col width="8%">
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
        <tbody>
          <template v-if="totalCnt == 0">
            <tr>
              <td colspan="7">일치하는 검색 결과가 없습니다</td>
            </tr>
          </template>
          <template v-else>
            <!--<tr v-for="item in items" :key="item.grp_cod">
              <td>{{ item.indexNew }}</td>
              <td id="groupTitle" @click="searchdetail(item.grp_cod)">
                {{ item.grp_cod }}
              </td>
              <td>{{ item.grp_cod_nm }}</td>
              <td>{{ item.grp_cod_eplti }}</td>
              <td>{{ item.use_poa }}</td>
              <td>{{ item.reg_date }}</td>
              <td>
                <a @click="rowClicked(item.grp_cod)" class="btnType3 color1"
                  ><span>수정</span></a
                >
              </td>
            </tr> -->
              <tr v-for="(item,index) in listNotice">
								<td>{{pageSize*(cpage-1)+1+index}}</td>  
								<td>{{item.bacc_code}}</td>
								<td>{{item.bacc_name}}</td>
								<td>{{item.dv_ep}}</td>
								<td>{{item.dv_fee}}</td>
							</tr> 
				<tbody id="listNotice">
				</tbody>				
			</table>


          </template>
        </tbody>
      </table>
    </div>

    <div id="comnGrpCodPagination">
      <paginate
        class="justify-content-center"
        v-model="currentPage"
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

    <br />
    <br />
    <br />
    <br />

    <div v-if="groupDetail.length">
      <p class="conTitle">
        <span>그룹 코드 상세</span>
        <span>
          <table
            style="collapse; border: 1px #50bcdf;"
            width="100%"
            cellpadding="5"
            cellspacing="0"
            border="1"
            align="left"
          >
            <tr style="border: 0px; border-color: blue">
              <td
                width="50"
                height="25"
                style="font-size: 100%; text-align: left"
              ></td>
            </tr>
          </table>
        </span>
      </p>

      <div class="divComGrpCodList">
        <table class="col">
          <caption>
            caption
          </caption>
          <colgroup>
            <col width="6%" />
            <col width="17%" />
            <col width="20%" />
            <col width="10%" />
          </colgroup>

          <thead>
            <tr>
              <th scope="col">번호</th>
              <th scope="col">그룹코드 상세</th>
              <th scope="col">그룹코드 상세명</th>
              <th scope="col">그룹코드 상세 설명</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="totalCnt == 0">
              <tr>
                <td colspan="7">일치하는 검색 결과가 없습니다</td>
              </tr>
            </template>
            <template v-else>
              <tr v-for="item in groupDetail" :key="item.grp_cod">
                <td>{{ item.row_num }}</td>
                <td>{{ item.dtl_cod }}</td>
                <td>{{ item.dtl_cod_nm }}</td>
                <td>{{ item.dtl_cod_eplti }}</td>
              </tr>
            </template>
          </tbody>
        </table>
      </div>

      <div id="comnGrpCodPagination2">
        <paginate
          class="justify-content-center"
          v-model="currentPage2"
          :page-count="page2()"
          :page-range="5"
          :margin-pages="0"
          :click-handler="clickCallback2"
          :prev-text="'Prev'"
          :next-text="'Next'"
          :container-class="'pagination'"
          :page-class="'page-item'"
        >
        </paginate>
      </div>
    </div>
  </div>
</template>
