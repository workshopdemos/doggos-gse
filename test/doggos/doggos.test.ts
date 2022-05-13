/* Copyright (c) 2022 Broadcom.
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED
*/
import {
  Test4zService,
  Filter,
  Operators,
  Types,
  FilterBuilder,
} from "@broadcom/test4z";
import { TestHelper } from "../TestHelper";

let ADOPTION_REPORT = ".DOGGOS.OUTPUT";
let REPORT_COPYBOOK = ".DOGGOS.COPY(ADOPTRPT)";
const REPORT_FILTER: InstanceType<typeof Filter>[] = [
  new FilterBuilder()
    .Fieldname("OUT-DOG-BREED")
    .Operator(Operators.NOTEQUAL)
    .Value([""])
    .Type(Types.CHARACTER)
    .build(),
];
let BATCH_APPLICATION = ".DOGGOS.JCL(RUNTEST)";
let HLQ: any, report, records: { [x: string]: any }[];

describe("Doggos Batch Application - Regression Test Suite", function () {
  beforeAll(async () => {
    HLQ = await Test4zService.getProfileProp("hlq");
  });
  test("Test the number of records in the adoption report", async function () {
    const job = await Test4zService.submitJobUsingDataset(
      HLQ + BATCH_APPLICATION
    );
    expect(String(job)).toMatch(/CC 0000|CC 0004/);

    report = await Test4zService.search(
      HLQ + ADOPTION_REPORT,
      HLQ + REPORT_COPYBOOK,
      REPORT_FILTER
    );
    expect(report).not.toBeNull();
    expect(report.data).not.toBeNull();
    const data = report.data;
    expect(data.Record.length).toBe(9);
    records = TestHelper.getReportRecords(data);
  });

  test("Test for SHIBA breed", () => {
    const adoptionAmount = TestHelper.getAdoptionAmount(records, "SHIBA");
    expect(adoptionAmount).toBe(8);
  });

  test("Test for KORGI breed", () => {
    const adoptionAmount = TestHelper.getAdoptionAmount(records, "KORGI");
    expect(adoptionAmount).toBe(7);
  });

  test("Test for CHI breed", () => {
    const adoptionAmount = TestHelper.getAdoptionAmount(records, "CHI");
    expect(adoptionAmount).toBe(1);
  });

  test("Test for JINGO breed", () => {
    const adoptionAmount = TestHelper.getAdoptionAmount(records, "JINGO");
    expect(adoptionAmount).toBe(6);
  });
});
