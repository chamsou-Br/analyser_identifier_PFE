
import { Table , Button} from 'rsuite';
import {useState} from "react"
const { Column, HeaderCell, Cell } = Table;
import 'rsuite/dist/rsuite-no-reset-rtl.css'; // Adjust the path as needed

// eslint-disable-next-line @typescript-eslint/ban-types

type transaction = {
    id : number ,
    email : string ,
    password : string , 
    age : number 
}

// eslint-disable-next-line no-empty-pattern
 const TransactionScreen : React.FC = () => {


    const [loading , setLoading] = useState<boolean>(false)
    const [data, setdata] = useState<transaction[]>([
    {
        id : 1,
        email : "chams@gmail.com",
        age : 13, 
        password : "kjfdke"
    },
    {
        id : 2,
        email : "chams@gmail.com",
        age : 13, 
        password : "kjfdke"
    },
    {
        id : 3,
        email : "chams@gmail.com",
        age : 13, 
        password : "kjfdke"
    },
    {
        id : 4,
        email : "chams@gmail.com",
        age : 13, 
        password : "kjfdke"
    },
]);



  return (
    <div>
        <h1>transactionScreen</h1>
   <Table
      height={420}
      data={data}
      loading={loading}
    >
      <Column width={190} align="center" fixed sortable>
        <HeaderCell>Id</HeaderCell>
        <Cell dataKey="id" />
      </Column>

      <Column width={400} sortable>
        <HeaderCell>Email</HeaderCell>
        <Cell dataKey="email" />
      </Column>

      <Column width={400} sortable>
        <HeaderCell>Age</HeaderCell>
        <Cell dataKey="age" />
      </Column>

      <Column width={500} sortable>
        <HeaderCell>Password</HeaderCell>
        <Cell dataKey="password" />
      </Column>
      <Column width={80} fixed="right">
        <HeaderCell>...</HeaderCell>

        <Cell style={{ padding: '6px' }}>
          {rowData => (
            <Button appearance="link" onClick={() => alert(`id:${rowData.id}`)}>
              Edit
            </Button>
          )}
        </Cell>
      </Column>

    </Table>
    </div>
  )
}


export default TransactionScreen