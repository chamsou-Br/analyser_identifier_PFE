import React , { useState , useEffect} from 'react'
import "../styles/invitations.css"
import HeaderPage from '../components/headerPage/headerPage'
import { IInvitationComplete } from '../helper/types';
import ClientHistoryCard from '../components/clientHistoryCard/clientHistoryCard';
import { fetchInvitationsAPI } from '../helper/callsApi';
import { useNavigate } from 'react-router';


function InvitaionsScreen() {

    const [search, setSearch] = useState<string>("");
    const navigate = useNavigate()
    const [invitations , setInvitation] = useState<IInvitationComplete[]>([])

    const handleInputSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setSearch(e.target.value);
      };

      const handleInputFocus = () => {
        setSearch("");
      };
      const handleSearch = () => {
        navigate("/invitation/" + search);
      };

    const handleGetInvitations = async () => {
       const res =  await fetchInvitationsAPI();
       if (res.invitation) {
        setInvitation(res.invitation);
       }
    }

    useEffect(()=>{
        handleGetInvitations();
    },[])
  


  return (
    <div className='invitations-page'>
      <HeaderPage
        isSeach
        handleChangeInput={handleInputSearchChange}
        handleFocusInput={handleInputFocus}
        handleSearch={handleSearch}
        value={search}
        title="Invitation List"
        descr="Information about Pending Invitation !"
        />
            <div className="content">
            {invitations.map((his, i) => (
                <div className='invitation'>
              <ClientHistoryCard key={i} history={his}  />
              </div>
            ))}
          </div>

    </div>
  )
}

export default InvitaionsScreen