# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate and supported version of .NET, such as `net8.0`. Ensure it is not targeting an end-of-life version like `net5.0` or `net6.0` unless there is a specific reason.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality and confirm that core features behave the same as they did in the legacy version.

### 5. Review Static Files and Middleware Configuration

If this is an ASP.NET Core web project, verify that the middleware pipeline in `Program.cs` or `Startup.cs` is correctly configured. Specifically check for:

- Static file serving (`UseStaticFiles`)
- Routing (`UseRouting`, `MapControllers`, `MapRazorPages`)
- Authentication and Authorization middleware, if applicable
- Any legacy `HttpModule` or `HttpHandler` equivalents that may need to be re-implemented as middleware

### 6. Check for Windows-Specific Dependencies

Inspect the codebase for any APIs or libraries that are Windows-specific and would not function on Linux or macOS. Common examples include:

- `System.Drawing` (replace with a cross-platform alternative such as `SkiaSharp` or `ImageSharp`)
- Windows Registry access
- COM interop

Use the .NET Compatibility Analyzer to assist with this:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
```

### 7. Database and Data Access Validation

If the project uses Entity Framework or another data access layer, run any pending migrations and verify the database schema is correct:

```bash
dotnet ef database update
```

Test all primary data access paths, including reads, writes, updates, and deletes.

### 8. Execute Tests

If a test project exists in the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and address the underlying issues before proceeding to deployment.

### 9. Review Configuration Files

Ensure that `appsettings.json` and any environment-specific variants (`appsettings.Development.json`, `appsettings.Production.json`) contain the correct values. Confirm that any settings previously stored in `Web.config` or `App.config` have been properly migrated.

### 10. Publish the Application

Once all validation steps pass, publish the application to verify the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.