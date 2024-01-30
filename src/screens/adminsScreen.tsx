/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { useEffect, useState } from "react";
import HeaderPage from "../components/headerPage/headerPage";
import { IAdmin, IDeliveryOffice } from "../helper/types";
import { addAdminAPI, blockAdminAPI, deleteDeliveryCompanyAPI, fetchDeliveryCompanyAPI, fetchListAdminsAPI } from "../helper/callsApi";
import "../styles/deliveryCompanies.css";
import Alert from "../components/Alert/alert";
import ActionConfirmation from "../components/ActionConfirmation/ActionConfirmation";
import NewAdminForm from "../components/newAdmin/newAdminForm";
import "../styles/admins.css"
import NewAdminCard from "../components/newAdmin/newAdminCard";

const AdminsScreen: React.FC = () => {

  const [admins, setAdmins] = useState<IAdmin[]>([]);

  const [adminIdToDelete, setAdminIdToDelete] = useState<number>();

  const [isDeleteAdminConfirmation , setIsDeleteAdminConfirmation] = useState(false)

  const [newAdmin , setNewAdmin] = useState("")

  const onCancelModelDeleteAdminConfirmation = () => {
    setIsDeleteAdminConfirmation(false)
  }

  const onDeleteAdminButton = (id : number) => {
    setIsDeleteAdminConfirmation(true)
    setAdminIdToDelete(id)
  }

  const onConfirmDeleteAdmin = async() => {
    const res = await  blockAdminAPI(adminIdToDelete!)
    if (res.error ) onAlert(false , res.error , true)
    else {
      onAlert(true , "The admin has been successfully blocked" , true)
      setAdmins(res.admins!)
  }
    setIsDeleteAdminConfirmation(false)
  }

  const [isAddAdmin, setIsAddAdmin] = useState(false)
  const [isConfirmation , setIsConfirmation] = useState(false)

  const onCancelModelAddAdmin = () => {
    setIsAddAdmin(false)
  }

  const onAddAdminButton = () => {
    setIsAddAdmin(true)
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

  const fetchAdmins = async () => {
    const res = await fetchListAdminsAPI();
    if (res.admins) {
      setAdmins(res.admins);
    }
  };

  useEffect(() => {
    fetchAdmins();
  }, []);


  const onOpenConfirmation = (name : string) => {
    setIsConfirmation(true)
    setNewAdmin(name)
    onCancelModelAddAdmin()
  }
  const onCancelConfirmation = () => {
    setIsConfirmation(false)
  }

  const onConfirmAddAdmin = async () => {
    const res = await addAdminAPI(newAdmin);
    onCancelConfirmation()
    setIsAddAdmin(false)
    if (res.error) {
        onAlert(false , res.error , true)
    }else {
        onAlert(true , "The admin has been successfully added" , true)
        setAdmins([res.admin! , ...admins])
    }

  }
  
  return (
    <div className="admins-page">
      <div className="header">
      <HeaderPage
        title="Admin List"
        descr="Information about All delivery campagne"
      />
      <div onClick={onAddAdminButton} className="add-admin-button" >Add Admin</div>
      </div>

      <div className="list">
        {admins.map((item) => (
          <div className="admin" key={item.id}>
            <NewAdminCard name={item.name}  onDeleteAdmin={()=>onDeleteAdminButton(item.id)} />
          </div>
        ))}
        {admins.length == 0 && (
          <div className="empty">
            There is no admin to display ...
          </div>
        )}
      </div>
      <ActionConfirmation
          confirmationText=" Are you sure that you want to add this admin ?"
          handleCanceled={onCancelConfirmation}
          isOpen={isConfirmation}
          handleSubmit={onConfirmAddAdmin}
        />
      <ActionConfirmation 
      isOpen={isDeleteAdminConfirmation}
      handleCanceled={onCancelModelDeleteAdminConfirmation}
      handleSubmit={onConfirmDeleteAdmin}
      submitButton="Delete"
      confirmationText="You're sure you want to remove this Admin.. ..."
       />
       <NewAdminForm 
       isOpen={isAddAdmin}
       handleCanceled={onCancelModelAddAdmin}
       handleSubmit={onOpenConfirmation} />
      <Alert alert={alert} onAlert={onAlert} />
    </div>
  );
};

export default AdminsScreen;
