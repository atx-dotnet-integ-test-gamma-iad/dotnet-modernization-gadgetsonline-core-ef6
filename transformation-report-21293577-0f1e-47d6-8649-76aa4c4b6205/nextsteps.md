# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build --configuration Release
```

Verify that the output reports `0 Error(s)` and `0 Warning(s)` (or review any warnings that may indicate deprecated APIs or compatibility concerns).

### 2. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest Long Term Support (LTS) release.

### 3. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality such as product browsing, cart operations, and any authentication flows behave correctly.

### 4. Execute Unit and Integration Tests

If a test project exists in the solution, run all tests to confirm no regressions were introduced during the migration:

```bash
dotnet test --configuration Release --logger "console;verbosity=detailed"
```

Review the output for any failing tests and address them before proceeding.

### 5. Check for Removed or Changed APIs

Review the code for any usages of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check in an e-commerce project include:

- `System.Web` references (these are not available in cross-platform .NET and should have been replaced with ASP.NET Core equivalents)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage — confirm these reference `Microsoft.AspNetCore.Http` types
- `Session` and `Cache` — confirm these use the ASP.NET Core middleware equivalents (`ISession`, `IMemoryCache`)
- Any Windows-specific APIs such as the registry or Windows identity impersonation

### 6. Validate Database Connectivity

If the project uses Entity Framework or direct ADO.NET connections, confirm the connection strings in `appsettings.json` are correct and that the application can connect to the database:

```bash
dotnet ef database update
```

If Entity Framework Core migrations are present, verify they apply cleanly.

### 7. Review Static Files and Bundling

Confirm that static assets (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files must be placed in the `wwwroot` directory and the middleware must be registered:

```csharp
app.UseStaticFiles();
```

Verify this call exists in `Program.cs` or `Startup.cs`.

### 8. Publish the Application

Once the above steps are validated, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present, then deploy the output to the target hosting environment.