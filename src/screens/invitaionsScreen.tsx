import React , { useState , useEffect} from 'react'
import "../styles/invitations.css"
import HeaderPage from '../components/headerPage/headerPage'
import ClientHistoryCard from '../components/clientHistoryCard/clientHistoryCard';
import { useNavigate } from 'react-router';
import { RootState, useAppDispatch } from '../state/store';
import { fetchInvitations } from '../state/actions/invitationsAction';
import { useSelector } from 'react-redux';
import Page404 from '../components/404/page404';


const InvitaionsScreen: React.FC = () => {

    const [search, setSearch] = useState<string>("");
    const navigate = useNavigate()
    const disaptch = useAppDispatch();
    const invitationsState = useSelector((state : RootState) => state.invitations)

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
      disaptch(fetchInvitations())
    }

    useEffect(()=>{
        handleGetInvitations();
    },[])
  


    if (!invitationsState.error) {
  return (
    <div className='invitations-page'>
      <HeaderPage
        isSeach
        searchPlaceHolder='Search Invitation'
        handleChangeInput={handleInputSearchChange}
        handleFocusInput={handleInputFocus}
        handleSearch={handleSearch}
        value={search}
        title="Invitation List"
        descr="Information about Pending Invitation !"
        />
            <div className="content">
            {invitationsState.invitations.map((his, i) => (
                <div className='invitation'>
              <ClientHistoryCard key={i} history={his}  />
              </div>
            ))}
          </div>

    </div>
  )
            }else {
              return <Page404 />
            }
}

export default InvitaionsScreen