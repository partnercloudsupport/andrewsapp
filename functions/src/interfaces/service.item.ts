import Picture from './picture'
interface ServiceItem {
    id: string //A
    prettyCreatedAt: string  //B
    prettyDueAt: string  //B
    status: string
    needsRepair: string
    priority: string
    customerName: string
    customerPhone: string
    dueDateTime: string //C
    hasUrine: boolean //D
    intake_notes: string //E
    isDone: boolean //F
    length: number //G
    width: number //H
    pictureURL: string //I
    price: number //J
    serviceName: string //K
    smGUID: string //L
    smWorkorderId: string //M
    tagColor: string //N
    tagId: string //O
    workorderId: string //P
    

}

export default ServiceItem;