unit pProdutos;

interface

uses
  pClasses, System.Generics.Collections, System.JSon, System.Net.HttpClient,
  System.SysUtils, System.Classes;

type
  TName = class
  private
    FIdioma: string;
    FNome: string;
    procedure SetIdioma(const Value: string);
    procedure SetNome(const Value: string);
  public
    property Idioma: string read FIdioma write SetIdioma;
    property Nome: string read FNome write SetNome;
  end;

  TDescription = class
  private
    FIdioma: string;
    FNome: string;
    procedure SetIdioma(const Value: string);
    procedure SetNome(const Value: string);
  public
    property Idioma: string read FIdioma write SetIdioma;
    property Nome: string read FNome write SetNome;
  end;

  THandle = class
  private
    FIdioma: string;
    FNome: string;
    procedure SetIdioma(const Value: string);
    procedure SetNome(const Value: string);
  public
    property Idioma: string read FIdioma write SetIdioma;
    property Nome: string read FNome write SetNome;
  end;

  TImages = class
  private
    Fproduct_id: Integer;
    Fid: Integer;
    Fsrc: string;
    procedure Setid(const Value: Integer);
    procedure Setproduct_id(const Value: Integer);
    procedure Setsrc(const Value: string);
  public
    property id: Integer read Fid write Setid;
    property product_id: Integer read Fproduct_id write Setproduct_id;
    property src: string read Fsrc write Setsrc;
  end;

  TCategories = class
  private
    Fname: string;
    Fparent: Integer;
    Fid: Integer;
    Fsubcategories: TArray<Integer>;
    Fhandle: TObjectList<THandle>;
    Fdescription: TObjectList<TDescription>;
    procedure Setid(const Value: Integer);
    procedure Setname(const Value: string);
    procedure Setparent(const Value: Integer);
    procedure Setsubcategories(const Value: TArray<Integer>);
    procedure Setdescription(const Value: TObjectList<TDescription>);
    procedure Sethandle(const Value: TObjectList<THandle>);
  public
    constructor Create;
    destructor Destroy; override;
    property id: Integer read Fid write Setid;
    property name: string read Fname write Setname;
    property description: TObjectList<TDescription> read Fdescription write Setdescription;
    property handle: TObjectList<THandle> read Fhandle write Sethandle;
    property parent: Integer read Fparent write Setparent;
    property subcategories: TArray<Integer> read Fsubcategories write Setsubcategories;
  end;

  TVariants = class
  private
    Fstock_management: Integer;
    Fupdated_at: TDate;
    Fstock: Integer;
    Fproduct_id: Integer;
    Fprice: Double;
    Fcreated_at: TDate;
    Fbarcode: string;
    Fpromotional_price: Double;
    Fimage_Id: Integer;
    Fid: Integer;
    procedure Setbarcode(const Value: string);
    procedure Setcreated_at(const Value: TDate);
    procedure Setid(const Value: Integer);
    procedure Setimage_Id(const Value: Integer);
    procedure Setprice(const Value: Double);
    procedure Setproduct_id(const Value: Integer);
    procedure Setpromotional_price(const Value: Double);
    procedure Setstock(const Value: Integer);
    procedure Setstock_management(const Value: Integer);
    procedure Setupdated_at(const Value: TDate);
  public
    property id: Integer read Fid write Setid;
    property image_Id: Integer read Fimage_Id write Setimage_Id;
    property product_id: Integer read Fproduct_id write Setproduct_id;
    property price: Double read Fprice write Setprice;
    property promotional_price: Double read Fpromotional_price write Setpromotional_price;
    property stock_management: Integer read Fstock_management write Setstock_management;
    property stock: Integer read Fstock write Setstock;
    property barcode: string read Fbarcode write Setbarcode;
    property created_at: TDate read Fcreated_at write Setcreated_at;
    property updated_at: TDate read Fupdated_at write Setupdated_at;
  end;

  TProdutos = class
  private
    Fvariants: TObjectList<TVariants>;
    Fname: TObjectList<TName>;
    Fimages: TObjectList<TImages>;
    Fpublicado: Boolean;
    Fvideo_url: string;
    Fcategories: TObjectList<TCategories>;
    Fhandle: TObjectList<THandle>;
    Fid: Integer;
    Ffree_shipping: Boolean;
    Fdescription: TObjectList<TDescription>;
    Fbrand: string;
    procedure Setbrand(const Value: string);
    procedure Setcategories(const Value: TObjectList<TCategories>);
    procedure Setdescription(const Value: TObjectList<TDescription>);
    procedure Setfree_shipping(const Value: Boolean);
    procedure Sethandle(const Value: TObjectList<THandle>);
    procedure Setid(const Value: Integer);
    procedure Setimages(const Value: TObjectList<TImages>);
    procedure Setname(const Value: TObjectList<TName>);
    procedure Setpublicado(const Value: Boolean);
    procedure Setvariants(const Value: TObjectList<TVariants>);
    procedure Setvideo_url(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property id: Integer read Fid write Setid;
    property name: TObjectList<TName> read Fname write Setname;
    property description: TObjectList<TDescription> read Fdescription write Setdescription;
    property handle: TObjectList<THandle> read Fhandle write Sethandle;
    property variants: TObjectList<TVariants> read Fvariants write Setvariants;
    property images: TObjectList<TImages> read Fimages write Setimages;
    property categories: TObjectList<TCategories> read Fcategories write Setcategories;
    property brand: string read Fbrand write Setbrand;
    property publicado: Boolean read Fpublicado write Setpublicado;
    property free_shipping: Boolean read Ffree_shipping write Setfree_shipping;
    property video_url: string read Fvideo_url write Setvideo_url;
  end;

implementation

{ TDescription }

procedure TDescription.SetIdioma(const Value: string);
begin
  FIdioma := Value;
end;

procedure TDescription.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TName }

procedure TName.SetIdioma(const Value: string);
begin
  FIdioma := Value;
end;

procedure TName.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ THandle }

procedure THandle.SetIdioma(const Value: string);
begin
  FIdioma := Value;
end;

procedure THandle.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TImages }

procedure TImages.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TImages.Setproduct_id(const Value: Integer);
begin
  Fproduct_id := Value;
end;

procedure TImages.Setsrc(const Value: string);
begin
  Fsrc := Value;
end;

{ TCategories }

constructor TCategories.Create;
begin

end;

destructor TCategories.Destroy;
begin
  Fdescription.Free;
  inherited;
end;

procedure TCategories.Setdescription(const Value: TObjectList<TDescription>);
begin
  if not Assigned(Fdescription) then
    Fdescription := TObjectList<TDescription>.Create;
  Fdescription := Value;
end;

procedure TCategories.Sethandle(const Value: TObjectList<THandle>);
begin
  if not Assigned(Fhandle) then
    Fhandle := TObjectList<THandle>.Create;
  Fhandle := Value;
end;

procedure TCategories.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TCategories.Setname(const Value: string);
begin
  Fname := Value;
end;

procedure TCategories.Setparent(const Value: Integer);
begin
  Fparent := Value;
end;

procedure TCategories.Setsubcategories(const Value: TArray<Integer>);
begin

end;

{ TVariants }

procedure TVariants.Setbarcode(const Value: string);
begin
  Fbarcode := Value;
end;

procedure TVariants.Setcreated_at(const Value: TDate);
begin
  Fcreated_at := Value;
end;

procedure TVariants.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TVariants.Setimage_Id(const Value: Integer);
begin
  Fimage_Id := Value;
end;

procedure TVariants.Setprice(const Value: Double);
begin
  Fprice := Value;
end;

procedure TVariants.Setproduct_id(const Value: Integer);
begin
  Fproduct_id := Value;
end;

procedure TVariants.Setpromotional_price(const Value: Double);
begin
  Fpromotional_price := Value;
end;

procedure TVariants.Setstock(const Value: Integer);
begin
  Fstock := Value;
end;

procedure TVariants.Setstock_management(const Value: Integer);
begin
  Fstock_management := Value;
end;

procedure TVariants.Setupdated_at(const Value: TDate);
begin
  Fupdated_at := Value;
end;

{ TProdutos }

constructor TProdutos.Create;
begin
  //
end;

destructor TProdutos.Destroy;
begin
  name.Free;
  description.Free;
  handle.Free;
  variants.Free;
  images.Free;
  categories.Free;
  inherited;
end;

procedure TProdutos.Setbrand(const Value: string);
begin
  Fbrand := Value;
end;

procedure TProdutos.Setcategories(const Value: TObjectList<TCategories>);
begin
  if not Assigned(Fcategories) then
    Fcategories := TObjectList<TCategories>.Create;

  Fcategories := Value;
end;

procedure TProdutos.Setdescription(const Value: TObjectList<TDescription>);
begin
  if not Assigned(Fdescription) then
    Fdescription := TObjectList<TDescription>.Create;

  Fdescription := Value;
end;

procedure TProdutos.Setfree_shipping(const Value: Boolean);
begin
  Ffree_shipping := Value;
end;

procedure TProdutos.Sethandle(const Value: TObjectList<THandle>);
begin
  if not Assigned(Fhandle) then
    Fhandle := TObjectList<THandle>.Create;

  Fhandle := Value;
end;

procedure TProdutos.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TProdutos.Setimages(const Value: TObjectList<TImages>);
begin
  if not Assigned(Fimages) then
    Fimages := TObjectList<TImages>.Create;

  Fimages := Value;
end;

procedure TProdutos.Setname(const Value: TObjectList<TName>);
begin
  if not Assigned(Fname) then
    Fname := TObjectList<TName>.Create;

  Fname := Value;
end;

procedure TProdutos.Setpublicado(const Value: Boolean);
begin
  Fpublicado := Value;
end;

procedure TProdutos.Setvariants(const Value: TObjectList<TVariants>);
begin
  if not Assigned(Fvariants) then
    Fvariants := TObjectList<TVariants>.Create;

  Fvariants := Value;
end;

procedure TProdutos.Setvideo_url(const Value: string);
begin
  Fvideo_url := Value;
end;

end.

