export class TestHelper {
  static getReportRecords(data: any): any {
    return data.Record.map(
      (a: { [x: string]: any }) => a["ADOPTED-REPORT-REC"]
    ).map((rec: { [x: string]: any }) => {
      return {
        dogBreed: rec["OUT-DOG-BREED"],
        adoptionAmount: rec["OUT-ADOPTED-AMOUNT"],
      };
    });
  }

  static getAdoptionAmount(data: any, name: any): any {
    let breed = data.filter((a: { dogBreed: string }) => a.dogBreed == name);
    if (!breed) return undefined;
    const adoptionAmounts = breed.map(
      (a: { adoptionAmount: any }) => a.adoptionAmount
    );
    return adoptionAmounts.reduce((sum: any, a: any) => sum + a, 0);
  }
}
