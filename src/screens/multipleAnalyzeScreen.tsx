/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-unused-vars */

import React, { useEffect, useRef, useState } from "react";
import "../styles/deliveryCompanyDetails.css";
import {
  IRowsTable,
  IColumnsForTable,
  IClassAnalyzer,
  ICluster,
} from "../helper/types";
import TableCompo from "../components/Table/Table";
import HeaderPage from "../components/headerPage/headerPage";

import {
  getClustersCandidates,
  getMultipleClassesAnalyzer,
} from "../helper/callsApi";

import ClassDetails from "../components/classDetails/classDetails";
import GlobalGraphModal from "../components/GlobalGraph/globalGraph";
import MsIdentificationForm from "../components/deliveryCompany/msIdentificationForm";
import MsCandidatesModal from "../components/msCandidatesModal/msCandidates";

// eslint-disable-next-line no-empty-pattern
const MultipleAnalyzeScreen: React.FC = () => {
  const urlParams = new URLSearchParams(window.location.search);

  const [classes, setClasses] = useState<IClassAnalyzer[]>([]);

  const urlParamValue = urlParams.get("path");

  const [openClassDetails, setOpenClassDetails] = useState(false);

  const [openGlobalGraph, setOpenGlobalGraph] = useState(false);

  const [openFormIdentifierMs, setOpenFormIdentifierMs] = useState(false);

  const [openMsModal, setOpenMsModal] = useState(false);

  const [loading , setLoading] = useState(false)

  const [classDetails, setClassDetails] = useState<IClassAnalyzer | undefined>(
    undefined
  );

  const [clusters, setClusters] = useState<ICluster[]>([]);

  const rows: IRowsTable[] = [
    { headerCell: "Class name", dataKey: "name", size: 300 },
    { headerCell: "Methods", dataKey: "methods", size: 200 },
    {
      headerCell: "Inter Dependencies",
      dataKey: "interDependencies",
      size: 300,
    },
    {
      headerCell: "Intra Dependencies",
      dataKey: "intraDependencies",
      size: 300,
    },
    { headerCell: "Data", dataKey: "data", size: 200 },
  ];

  const getDataFromState = (): IColumnsForTable[] => {
    const newData = classes.map((item: IClassAnalyzer) => ({
      name: item.class_name,
      methods: item.methods.length,
      interDependencies: [...new Set(item.interdependences)].length ,
      intraDependencies: item.intradependences,
      data: "-",
      fileName: item.filename,
    }));
    return newData;
  };

  useEffect(() => {
    const onFetchClasses = async () => {
      const res = await getMultipleClassesAnalyzer(urlParamValue || "");
      if (res.classes){
        setLoadingClasses(false)
        setClasses(res.classes);
      }
    };
    onFetchClasses();
  }, []);

  const handleOpenClassDetailsModal = (data: IClassAnalyzer) => {
    setClassDetails(data);
    setOpenClassDetails(true);
  };

  const handleCancelClassDetailsModal = () => {
    setOpenClassDetails(false);
    setClassDetails(undefined);
  };

  const handleOpenGlobalGraphModal = () => {
    setOpenGlobalGraph(true);
  };

  const handleCancelGlobalGraphModal = () => {
    setOpenGlobalGraph(false);
  };

  const handleOpenFormIdentifierMs = () => {
    setOpenFormIdentifierMs(true);
  };

  const handleSubmitIdentifyMs = async (alpha: number, beta: number) => {
    setLoading(true)
    const res = await getClustersCandidates(urlParamValue!, alpha, beta);
    if (res.clusters) {
      setLoading(false)
      setClusters(res.clusters);
      handleOpenMsModal();
    }
    handleCancelFormIdentifierMs();
  };

  const handleCancelFormIdentifierMs = () => {
    setOpenFormIdentifierMs(false);
  };

  const handleOpenMsModal = () => {
    setOpenMsModal(true);
  };

  const handleCloseMsModal = () => {
    setOpenMsModal(false);
  };

  const [laodingClasses , setLoadingClasses] = useState(true)
  return (
    <div className="transaction-of-company-container">
      <div className="header">
        <HeaderPage
          title={"Classes Analyzer : "}
          descr={"All classes with their Call graph"}
          onHandleGlobalCallGraph={handleOpenGlobalGraphModal}
          handleOpenFormIdentifierMs={handleOpenFormIdentifierMs}
        />
      </div>

      <>
        <TableCompo
        loader={laodingClasses}
          isSearch={false}
          searchPlaceHolder="Search Transaction"
          rows={rows}
          getDefaultData={getDataFromState}
          onRefreshData={() => {}}
          pageSize={10}
          onViewable={(rowData: IColumnsForTable) => {
            handleOpenClassDetailsModal(
              classes.filter((it) => it.class_name == rowData.name)[0]
            );
          }}
          isRefresh={false}
        />
      </>
      {openGlobalGraph && (
        <GlobalGraphModal
          isOpen={openGlobalGraph}
          handleCanceled={handleCancelGlobalGraphModal}
          path={urlParamValue!}
        />
      )}

      <ClassDetails
        isOpen={openClassDetails}
        handleCanceled={handleCancelClassDetailsModal}
        data={classDetails}
      />

      <MsIdentificationForm
      loading={loading}
        isOpen={openFormIdentifierMs}
        handleSubmit={handleSubmitIdentifyMs}
        handleCanceled={handleCancelFormIdentifierMs}
      />

      <MsCandidatesModal
        clusters={clusters}
        isOpen={openMsModal}
        handleCanceled={handleCloseMsModal}
      />
    </div>
  );
};
export default MultipleAnalyzeScreen;
