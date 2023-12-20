import React, { useEffect, useState } from "react";
import HeaderPage from "../components/headerPage/headerPage";
import { IDeliveryOffice } from "../helper/types";
import DeliveryCompanyCard from "../components/deliveryCompany/deliveryCompanyCard";
import { addDeliveryCompanyAPI, deleteDeliveryCompanyAPI, fetchDeliveryCompanyAPI } from "../helper/callsApi";
import "../styles/deliveryCompanies.css";
import Alert from "../components/Alert/alert";
import ActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import DeliveryCompanyForm from "../components/deliveryCompany/deliveryCompanyForm";


const DeliveryCompanyScreen: React.FC = () => {

  const [companies, setCompanies] = useState<IDeliveryOffice[]>([]);

  const [companyIdToDelete, setCompanyIdToDelete] = useState<number>();

  const [isDeleteCompanyConfirmation , setIsDeleteCompanyConfirmation] = useState(false)

  const onCancelModelDeleteCompanyConfirmation = () => {
    setIsDeleteCompanyConfirmation(false)
  }

  const onDeleteCompanyButton = (id : number) => {
    setIsDeleteCompanyConfirmation(true)
    setCompanyIdToDelete(id)
  }

  const onConfirmDeleteCompany = async() => {
    const res = await  deleteDeliveryCompanyAPI(companyIdToDelete!)
    if (res.error ) onAlert(false , res.error , true)
    else {
      onAlert(true , "The company has been successfully removed" , true)
      setCompanies(companies.filter(item => item.id != companyIdToDelete))
  }
    setIsDeleteCompanyConfirmation(false)
  }

  const [isAddCompany, setIsAddCompany] = useState(false)

  const onCancelModelAddCompany = () => {
    setIsAddCompany(false)
  }

  const onAddCompanyButton = () => {
    setIsAddCompany(true)

  }

  const onConfirmAddCompany = async (company : string , email : string , phoneNumber : string) => {
    const res = await addDeliveryCompanyAPI(company , email , phoneNumber);
    if (res.error) onAlert(false , res.error , true)
    else {
      setCompanies([...companies! , res.company!])
      onAlert(true , "The company has been successfully added" , true)
    }
    setIsAddCompany(false)
  }

  /* start alert function */

  const [alert, setAlert] = React.useState({
    isSucess: false,
    message: "",
    show: false,
  });

  const onAlert = (isSucess: boolean, message: string, show: boolean) => {
    setAlert({
      isSucess,
      message,
      show,
    });
  };

  /* End alert functions */

  const fetchCompanies = async () => {
    const res = await fetchDeliveryCompanyAPI();
    if (res.companies) {
      setCompanies(res.companies);
    }
  };



  useEffect(() => {
    fetchCompanies();
  }, []);
  return (
    <div className="delivery-companies-page">
      <div className="header">
      <HeaderPage
        title="Delivery campagne"
        descr="Information about All delivery campagne"
      />
      <div onClick={onAddCompanyButton} className="add-company-button" >Add company</div>
      </div>

      <div className="list">
        {companies.map((item) => (
          <div className="company" key={item.id}>
            <DeliveryCompanyCard onDelete={()=>onDeleteCompanyButton(item.id)} company={item} key={item.id} />
          </div>
        ))}
        {companies.length == 0 && (
          <div className="empty">
            There is no delivery companies to display ...
          </div>
        )}
      </div>
      <ActionConfirmation 
      isOpen={isDeleteCompanyConfirmation}
      handleCanceled={onCancelModelDeleteCompanyConfirmation}
      handleSubmit={onConfirmDeleteCompany}
      submitButton="Delete"
      confirmationText="You're sure you want to remove this campany.. ..."
       />
       <DeliveryCompanyForm 
       isOpen={isAddCompany}
       handleCanceled={onCancelModelAddCompany}
       handleSubmit={onConfirmAddCompany} />
      <Alert alert={alert} onAlert={onAlert} />
    </div>
  );
};

export default DeliveryCompanyScreen;
