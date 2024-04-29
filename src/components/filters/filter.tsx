/* eslint-disable @typescript-eslint/no-explicit-any */
import { useState } from "react";
import { FilterField, PayPartFilterValues, TypeField } from "../../helper/types";
import { Button, Checkbox, DatePicker, Modal, SelectPicker } from "rsuite";
import "./filter.css"
import filter from "../../assets/filter.svg";


type Props = {
  fields: Array<FilterField>;
  onFilter: (values : PayPartFilterValues) => void;
  onClear : () => void,
  title? : string,
  modalTitle? : string
};

function Filter({ fields , onClear , onFilter , title , modalTitle}: Props) {

    const onHandleFilter = () => {
        const values: { [key: string]: string } = {};
        for (const item of fields) {
            values[item.name] = item.value;
        }
        onFilter(values)
        onCloseFilterModal()
    }

    const onHandleFilterForField = (field : FilterField , v : any) => {
        field.onSet(v)
        const values: { [key: string]: string } = {};
        for (const item of fields) {
            values[item.name] = item.name == field.name ? v :  item.value;
        }
        onFilter(values)
    }

    const onHandleFilterForFieldCheckbox = (field : FilterField ) => {
      const v = !field.value
      field.onSet(v)
      const values: { [key: string]: string } = {};
      for (const item of fields) {
          values[item.name] = item.name == field.name ? v :  item.value;
      }
      onFilter(values)
  }

    const [isOpenFiltersModal, setIsOpenFiltersModal] = useState(false);

    const onOpenFilterModal = () => {
      setIsOpenFiltersModal(true);
    };
    const onCloseFilterModal = () => {
      setIsOpenFiltersModal(false);
    };

  return (
    <div className="filter-component" >
    <div className="filters-content">
    <div className="filters">
      {fields.map((field, index) => (
        <div className="filter" key={index}>
          <div className="label">{field.label}</div>
          <div className="input-container">
            {field.type == TypeField.checkbox ? (
              <Checkbox 
              className="filter-input checkbox"
              value={field.value}
              onChange={() => {onHandleFilterForFieldCheckbox(field)}}
              >
                {field.placeHolder}
              </Checkbox>
            ) : field.type == TypeField.select ? (
              <SelectPicker          
                className="filter-input products-select"
                block
                value={field.value}
                onChange={(p) => {onHandleFilterForField(field , p)}}
                data={Array.from(new Set(field.data || [])) }
                searchable={false}
                placeholder={field.placeHolder}
              />
            ) : (
              <DatePicker
                className="filter-input "
                format="yyyy-MM-dd"
                value={field.value as Date}
                onChange={(d) => onHandleFilterForField(field , d)}
                block
                size="md"
                placeholder={field.placeHolder}
              />
            )}
          </div>
        </div>
      ))}
    </div>
    <div onClick={onClear} className="filter-clear">Supprimer mon filtre</div>
    </div>


    <div className="filter-header">
          <div className="title">
            {title}
            <div onClick={onOpenFilterModal} className="filter-open-modal">
              Filter
              <img src={filter} />
            </div>
          </div>
        </div>
      <Modal  open={isOpenFiltersModal} onClose={onCloseFilterModal}>
        <div className="filters-modal">
        <div className="title">{modalTitle ? modalTitle :  "Filtrer la list"}</div>
        {fields.map((field, index) => (
          <div className="filter-modal" key={index}>
            <div className="label">{field.name}</div>
            <div className="input-container">
              {field.type == TypeField.checkbox ? (
                    <Checkbox 
                    className="filter-input "
                    checked={field.value as boolean}
                    onChange={(p) => field.onSet(p)}
                    > {field.label} 
                    </Checkbox>
              ) :  field.type == TypeField.select ? (
                <SelectPicker
                  className="filter-input products-select"
                  block
                  value={field.value}
                  onChange={(p) => field.onSet(p)}
                  data={field.data || []}
                  searchable={false}
                  placeholder={field.placeHolder}
                />
              ) : (
                <DatePicker
                  className="filter-input "
                  format="yyyy-MM-dd"
                  value={field.value as Date}
                  onChange={(d) => field.onSet(d)}
                  block
                  size="md"
                  placeholder={field.placeHolder}
                />
              )}
            </div>
          </div>
        ))}
        <div onClick={onHandleFilter} className="filter-button">Filtrer</div>
        <div onClick={onClear} className="filter-clear">Supprimer mon filtre</div>
        </div>
        <Modal.Footer>
        <Button
          className="button close"
          onClick={onCloseFilterModal}
          appearance="subtle"
          style={{color : '#7800A2', marginTop : 20}}
        >
          Annuler
        </Button>
      </Modal.Footer>
      </Modal>
    </div>
  );
}

export default Filter;
